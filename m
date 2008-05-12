Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 18:12:38 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:56332 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20031365AbYELRMf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 18:12:35 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 74969D8E5; Mon, 12 May 2008 17:12:29 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 612F0372609; Mon, 12 May 2008 19:12:16 +0200 (CEST)
Date:	Mon, 12 May 2008 19:12:16 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Cobalt drivers/media build failure
Message-ID: <20080512171216.GA19598@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

With the Debian config (that enables a lot of modules) I get the
following build error on Cobalt with 2.6.26-rc1:

  MODPOST 778 modules
ERROR: "i2c_master_send" [drivers/media/video/tuner.ko] undefined!
ERROR: "i2c_detach_client" [drivers/media/video/tuner.ko] undefined!
ERROR: "i2c_del_driver" [drivers/media/video/tuner.ko] undefined!
ERROR: "v4l2_i2c_attach" [drivers/media/video/tuner.ko] undefined!
ERROR: "i2c_register_driver" [drivers/media/video/tuner.ko] undefined!
ERROR: "i2c_master_recv" [drivers/media/video/tuner.ko] undefined!
ERROR: "i2c_probe" [drivers/media/video/tuner.ko] undefined!
ERROR: "i2c_register_driver" [drivers/media/video/mt9v022.ko] undefined!
ERROR: "i2c_smbus_write_word_data" [drivers/media/video/mt9v022.ko] undefined!
ERROR: "i2c_smbus_read_word_data" [drivers/media/video/mt9v022.ko] undefined!
ERROR: "i2c_del_driver" [drivers/media/video/mt9v022.ko] undefined!
ERROR: "i2c_register_driver" [drivers/media/video/mt9m001.ko] undefined!
ERROR: "i2c_smbus_write_word_data" [drivers/media/video/mt9m001.ko] undefined!
ERROR: "i2c_smbus_read_word_data" [drivers/media/video/mt9m001.ko] undefined!
ERROR: "i2c_del_driver" [drivers/media/video/mt9m001.ko] undefined!
ERROR: "i2c_transfer" [drivers/media/common/tuners/xc5000.ko] undefined!
ERROR: "i2c_transfer" [drivers/media/common/tuners/tuner-xc2028.ko] undefined!
ERROR: "i2c_transfer" [drivers/media/common/tuners/tuner-simple.ko] undefined!
ERROR: "i2c_clients_command" [drivers/media/common/tuners/tuner-simple.ko] undefined!
ERROR: "i2c_transfer" [drivers/media/common/tuners/tea5767.ko] undefined!
ERROR: "i2c_transfer" [drivers/media/common/tuners/tea5761.ko] undefined!
ERROR: "i2c_transfer" [drivers/media/common/tuners/tda9887.ko] undefined!
ERROR: "i2c_transfer" [drivers/media/common/tuners/tda8290.ko] undefined!
ERROR: "i2c_transfer" [drivers/media/common/tuners/mt20xx.ko] undefined!

-- 
Martin Michlmayr
http://www.cyrius.com/
