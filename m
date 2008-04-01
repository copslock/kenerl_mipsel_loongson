Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 10:40:29 +0200 (CEST)
Received: from mx.mips.com ([63.167.95.198]:58520 "EHLO dns0.mips.com")
	by lappi.linux-mips.net with ESMTP id S1101018AbYDAIkV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 10:40:21 +0200
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m318VspA008956
	for <linux-mips@linux-mips.org>; Tue, 1 Apr 2008 00:31:55 -0800 (PST)
Received: from [127.0.0.1] (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m318WlCb002510
	for <linux-mips@linux-mips.org>; Tue, 1 Apr 2008 01:32:48 -0700 (PDT)
Message-ID: <47F1F349.7010503@mips.com>
Date:	Tue, 01 Apr 2008 10:33:13 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: max_pfn: Uninitialized, or Deprecated?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Once upon a time, the global max_pfn value was set up as part of
bootmem_init(), but this seems to have been dropped in favor of
establishing max_low_pfn, I suppose to be clear that it's the max
non-highmem PFN.  However, the global max_pfn gets used in
the MIPS APRP support code,  and also in places like
block/blk-settings.c.  Is the use of max_pfn supposed to be
deprecated, such that we consider blk-settings.c to be broken
and change arch/mips/kernel/vpe.c to use max_low_pfn, or
ought we assign  max_pfn = max_low_pfn in bootmem_init()?

I'm going to try the later for my own experimental purposes,
but won't propose a patch until I have a better understanding
of why things changed.

          Regards,

          Kevin K.
 
