Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jan 2006 03:37:05 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.206]:19296 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133835AbWAGDgs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Jan 2006 03:36:48 +0000
Received: by wproxy.gmail.com with SMTP id 36so2988747wra
        for <linux-mips@linux-mips.org>; Fri, 06 Jan 2006 19:39:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I1kW2CCPDtkoxj+NvQlmBT8FTYN8gBBu+hcqO4jrpkgO6DlfvRGnnrvBSPx0OUt4yj+o2CiSXcHHf/YqfFTmm6so8e34lzzCU/4OryKPJZbdEBHU5SFhM5B3qWDncIHXXqq6wt6qKJSSXD5fHLpDXT2Wo6lsooeOtkKttmZz8e0=
Received: by 10.54.158.2 with SMTP id g2mr1596625wre;
        Fri, 06 Jan 2006 19:38:46 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Fri, 6 Jan 2006 19:39:32 -0800 (PST)
Message-ID: <50c9a2250601061939j42c4cc85n1c0246d9f8068938@mail.gmail.com>
Date:	Sat, 7 Jan 2006 11:39:32 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	jp <jaypee@hotpop.com>
Subject: Re: sometimes get "crc error" while uncompressed ramdisk
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1136537813.5239.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601052240n5696e353teb2b798ecbf802f0@mail.gmail.com>
	 <1136537813.5239.23.camel@localhost.localdomain>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/6/06, jp <jaypee@hotpop.com> wrote:
> On Fri, 2006-01-06 at 14:40 +0800, zhuzhenhua wrote:
> > i make a ramdisk by myself, and sometimes the kernel boot the ramdisk
> > correctly but sometimes it printk "crc error" while uncompressed
> > ramdisk, did someone meet this situation?
> > thanks for any hints
> >
>
> Assuming your build and everything else is as it should be it may be a
> RAM fault. Are you using a custom board?
>
> I had some prototype boards here with some really long tracks to RAM.
> (and some really short ones too!)
>
> Memory tests such walking ones worked fine but the decompress of the
> ramdisk works RAM pretty hard and it showed up intermittent faults like
> you describe. Tended to be worse when the board was warm. I'd spray some
> Freezit on and it would go back to working OK.
>
> You could also try running the RAM slower and see if the fault
> disappears.
>
>
> JP
>
>
>
maybe you are right, because i work on our FPGA board, and the
situation is similiar as your description. i will try to slow down the
sdram and to see what will happen

thanks!

Best regards

zhuzhenhua
