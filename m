Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M0iDP19213
	for linux-mips-outgoing; Mon, 21 Jan 2002 16:44:13 -0800
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M0iBP19210
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 16:44:11 -0800
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 21 Jan 2002 23:47:13 UT
Received: from venus (venus.esstech.com [193.5.205.5])
	by mail.esstech.com (8.11.6/8.11.6) with SMTP id g0LNg9W13674
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 15:42:09 -0800 (PST)
Received: from bud.austin.esstech.com by venus (SMI-8.6/SMI-SVR4)
	id PAA07631; Mon, 21 Jan 2002 15:43:29 -0800
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id RAA15559; Mon, 21 Jan 2002 17:37:32 -0600
Message-ID: <3C4CA8C8.5010801@esstech.com>
Date: Mon, 21 Jan 2002 17:48:24 -0600
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: ide dma in latest cvs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Does the latest CVS version work with an IDE controller in DMA mode?

I have an NEC VR5432 based system working with the IDE controller, but it
crashes when used in dma mode.  I've tracked it down to the following code
called from ide_build_sglist():

- blk_rq_map_sg() is called to build a list of blocks to be transferred.
   It sets address = NULL for every entry (other fields like "page" are
   set to valid values).

- dma_cache_wback_inv(addr, size) is called for each block entry.  This
   routine crashes because the address parameter is always set to zero
   when the routine is called.

I see that this is part of the new bio code recently added.  Should I expect
this code to work, or is it not yet working for the mips platform?

Thanks.

Gerald
