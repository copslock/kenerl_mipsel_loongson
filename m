Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 21:06:55 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:31167 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993411AbcLGUGtM0ClY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 21:06:49 +0100
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id uB7K6gRC015131
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2016 20:06:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id uB7K6fOI013007
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2016 20:06:42 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id uB7K6f6D032489;
        Wed, 7 Dec 2016 20:06:41 GMT
Received: from elgon.mountain (/197.157.0.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Dec 2016 12:06:40 -0800
Date:   Wed, 7 Dec 2016 22:58:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [bug report] [MIPS] Sibyte: Fix ZBbus profiler
Message-ID: <20161207195820.GA17588@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello Ralf Baechle,

The patch bb9b813bb665: "[MIPS] Sibyte: Fix ZBbus profiler" from Mar
9, 2007, leads to the following static checker warning:

	arch/mips/sibyte/common/sb_tbprof.c:480 sbprof_tb_read()
	warn: maybe return -EFAULT instead of the bytes remaining?

arch/mips/sibyte/common/sb_tbprof.c
   452  static ssize_t sbprof_tb_read(struct file *filp, char *buf,
   453                                size_t size, loff_t *offp)
   454  {
   455          int cur_sample, sample_off, cur_count, sample_left;
   456          char *src;
   457          int   count   =  0;
   458          char *dest    =  buf;
   459          long  cur_off = *offp;
   460  
   461          if (!access_ok(VERIFY_WRITE, buf, size))
   462                  return -EFAULT;
   463  
   464          mutex_lock(&sbp.lock);
   465  
   466          count = 0;
   467          cur_sample = cur_off / TB_SAMPLE_SIZE;
   468          sample_off = cur_off % TB_SAMPLE_SIZE;
   469          sample_left = TB_SAMPLE_SIZE - sample_off;
   470  
   471          while (size && (cur_sample < sbp.next_tb_sample)) {
   472                  int err;
   473  
   474                  cur_count = size < sample_left ? size : sample_left;
   475                  src = (char *)(((long)sbp.sbprof_tbbuf[cur_sample])+sample_off);
   476                  err = __copy_to_user(dest, src, cur_count);
   477                  if (err) {
   478                          *offp = cur_off + cur_count - err;
   479                          mutex_unlock(&sbp.lock);
   480                          return err;

This doesn't look right.  __copy_to_user() returns the number of bytes
remaining to be copied so I think we should return either -EFAULT or
"count + cur_count - err".

   481                  }
   482                  pr_debug(DEVNAME ": read from sample %d, %d bytes\n",
   483                           cur_sample, cur_count);
   484                  size -= cur_count;
   485                  sample_left -= cur_count;
   486                  if (!sample_left) {
   487                          cur_sample++;
   488                          sample_off = 0;
   489                          sample_left = TB_SAMPLE_SIZE;
   490                  } else {
   491                          sample_off += cur_count;
   492                  }
   493                  cur_off += cur_count;
   494                  dest += cur_count;
   495                  count += cur_count;
   496          }
   497          *offp = cur_off;
   498          mutex_unlock(&sbp.lock);
   499  
   500          return count;
   501  }

regards,
dan carpenter
