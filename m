Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 15:18:50 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:7296 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S8225321AbTKTPSj>;
	Thu, 20 Nov 2003 15:18:39 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id hAKFLRt00738;
	Thu, 20 Nov 2003 10:21:27 -0500
Message-ID: <3FBCDBF7.7000307@embeddededge.com>
Date: Thu, 20 Nov 2003 10:21:27 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Colin.Helliwell@Zarlink.Com
CC: linux-mips@linux-mips.org
Subject: Re: Compressed kernels
References: <OF86946D75.0D269E58-ON80256DE4.0031F58D@zarlink.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Colin.Helliwell@Zarlink.Com wrote:

> I'm running a 2.4.21 kernel tree, and would like to have kernel
> compression. I wondered if this has gone back into the latest versions yet?

If you apply the 'zImage' patch from Pete's ftp directory (look in past
e-mails for this discussion) you will see what I have done for a few of
the boards I'm using.  It's quite trivial to add new boards to get
this feature.  I'm still working on the method of attaching the
compressed initrd to the same image, which I find quite useful for
embedded applications.

Have fun!


	-- Dan
