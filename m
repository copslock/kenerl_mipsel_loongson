Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 19:50:10 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:15834 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225226AbUARTuJ>;
	Sun, 18 Jan 2004 19:50:09 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0IJo7w1018508
	for <linux-mips@linux-mips.org>; Sun, 18 Jan 2004 20:50:08 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id UAA22663
	for linux-mips@linux-mips.org; Sun, 18 Jan 2004 20:50:06 +0100 (MET)
Date: Sun, 18 Jan 2004 20:50:06 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: linux-mips@linux-mips.org
Subject: DMA_NONCOHERENT and dma_map_single
Message-ID: <20040118195006.GA22616@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

Hi,

  dma_map_single() is supposed to be called on a buffer that exactly
  starts and ends on a cacheline boundary, otherwise "bad things"
  (e.g. overwrite of data that was written by device, ...) (especially
  on dma non-coherent systems) may happen. 

  So what should be done when dma_map_single is not called
  with a sane (ptr, size) argument ?

    - is the driver (caller) considered buggy and should we return a 0
      return-value ?
    - is the driver (caller) considered buggy but we do the mapping
      anyway, hoping that the driver has not/will not touched/touch
      the boundary cachelines ?
    - should we take appropriate actions to make sure the
      cache-effects do not come into play (e.g. by using some kind of
      bounce buffer) ?


  Dimitri

-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
