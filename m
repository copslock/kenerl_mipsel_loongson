Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2006 00:53:24 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.188]:35738 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039426AbWKWAxU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Nov 2006 00:53:20 +0000
Received: by nf-out-0910.google.com with SMTP id l24so680038nfc
        for <linux-mips@linux-mips.org>; Wed, 22 Nov 2006 16:53:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FgOvS+PiSpRrNnWKIHRNdeEw/3QTt38q7HBD1zG/qRFtWpmlY1M7lqHja+aAAV5qc1r5eL85y5L3FaCWSuiHzsRCG2ZXq/pDb+31j+0uvDtk+2SoQk+xBtARzf7vYE9IkHCr19kbPJ432B4gT9D6zTanxWMy++WNo85I8+fN+aM=
Received: by 10.82.126.5 with SMTP id y5mr1342401buc.1164243199778;
        Wed, 22 Nov 2006 16:53:19 -0800 (PST)
Received: by 10.82.178.4 with HTTP; Wed, 22 Nov 2006 16:53:19 -0800 (PST)
Message-ID: <50c9a2250611221653p255b2c0em218f69c32897147a@mail.gmail.com>
Date:	Thu, 23 Nov 2006 08:53:19 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: about r4k_dma_cache_inv and r4k_dma_cache_wback_inv in c-r4k.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i see they all call 			
flush_dcache_line(a);	/* Hit_Writeback_Inv_D */

why didn't the r4k_dma_cache_inv call
 invalidate_dcache_line(unsigned long addr)        /* Hit_Invalidate_D */;


Best Regards
zhuzhenhua
