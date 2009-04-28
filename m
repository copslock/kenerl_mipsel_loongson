Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 11:50:14 +0100 (BST)
Received: from gateway10.websitewelcome.com ([69.56.148.20]:49250 "HELO
	gateway10.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20025348AbZD1KuI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 11:50:08 +0100
Received: (qmail 689 invoked from network); 28 Apr 2009 10:52:27 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway10.websitewelcome.com with SMTP; 28 Apr 2009 10:52:27 -0000
Received: from [217.109.65.213] (port=1190 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1Lyksz-0003ct-BS; Tue, 28 Apr 2009 05:50:01 -0500
Message-ID: <49F6DF5C.9080506@paralogos.com>
Date:	Tue, 28 Apr 2009 12:50:04 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Christoph Hellwig <hch@lst.de>
CC:	Shane McDonald <mcdonald.shane@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
References: <E1LyQQX-00047N-6E@localhost> <20090427130952.GA30817@linux-mips.org> <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com> <b2b2f2320904272321l4cf30181rcde6b1d42a5b5547@mail.gmail.com> <20090428092137.GB2408@lst.de>
In-Reply-To: <20090428092137.GB2408@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> On Tue, Apr 28, 2009 at 12:21:09AM -0600, Shane McDonald wrote:
>   
>> 4. Remove the entire get_ramroot() code, both squashfs and cramfs, as
>> Christoph has suggested.  I am hesitant to do this as it also affects code
>> in the MTD subsystem (file maps/pmcmsp-ramroot.c), and it also loses some
>> functionality on the PMC boards (putting the rootfs in RAM immediately
>> following the kernel).  Perhaps there's a better way to handle this?
>>     
>
> If the rootfs really is in ram only (and thus you discard any changes to
> it) you can just use an initramfs which is a lot simpler than any of the
> cramfs and squashfs hacks and supported by platform-independent code.
>   
I second that emotion.

          Kevin K.
