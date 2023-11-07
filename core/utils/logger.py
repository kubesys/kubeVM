'''
Copyright (2021, ) Institute of Software, Chinese Academy of Sciences

@author: wuyuewen@otcaix.iscas.ac.cn
@author: wuheng@otcaix.iscas.ac.cn
'''

try:
    from utils import constants
except:
    import constants

import logging
import logging.handlers

def set_logger(header,fn):
    logger = logging.getLogger(header)
    
    handler1 = logging.StreamHandler()
    handler2 = logging.handlers.RotatingFileHandler(filename=fn, maxBytes=int(constants.KUBEVMM_LOG_FILE_SIZE_BYTES), 
                                                    backupCount=int(constants.KUBEVMM_LOG_FILE_RESERVED))
    
    logger.setLevel(logging.DEBUG)
    handler1.setLevel(logging.ERROR)
    handler2.setLevel(logging.DEBUG)
    
    formatter = logging.Formatter("%(asctime)s %(name)s %(lineno)s %(levelname)s %(message)s")
    handler1.setFormatter(formatter)
    handler2.setFormatter(formatter)
    
    logger.addHandler(handler1)
    logger.addHandler(handler2)
    return logger
