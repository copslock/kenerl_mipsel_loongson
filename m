Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 21:39:27 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:25472 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S8225320AbTKTVjP>;
	Thu, 20 Nov 2003 21:39:15 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id hAKLg7t00974;
	Thu, 20 Nov 2003 16:42:07 -0500
Message-ID: <3FBD352F.6020103@embeddededge.com>
Date: Thu, 20 Nov 2003 16:42:07 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Colin.Helliwell@Zarlink.Com, linux-mips@linux-mips.org
Subject: Re: Compressed kernels
References: <OF86946D75.0D269E58-ON80256DE4.0031F58D@zarlink.com> <3FBCDBF7.7000307@embeddededge.com> <20031120210257.GA758@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> Compressed kernels seem to be fairly high on everybody's list.  Due to
> size limits of some boatloaders and flash memory being always too small
> and too expensive I guess there would also be some interest in bzip2
> support.

Interesting thought.  I compressed the binary image using bzip2 instead
of gzip, found it was only about 7% smaller (approximately 60K bytes).
To this, we have to add the trade off that the kernel already contains
too many versions of a readily available zlib, and the attached initrd
is also a gzip file.  Five years ago we used to be concerned about a
few bytes here and there, which prompted the interest in compressed
kernels, but today the embedded systems I'm working with have lots of
flash memory.  It seems product development cost to add a little more
flash is winning over spending the engineering time to squeeze those
last few bytes.

I don't think I'll spend my time doing it, but the process of creating
the compressed image and the calls to the uncompress functions are very
clear if someone else wants to do it :-)

Thanks.


	-- Dan
