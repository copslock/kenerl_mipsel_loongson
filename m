Received:  by oss.sgi.com id <S553912AbQLQJoe>;
	Sun, 17 Dec 2000 01:44:34 -0800
Received: from mail.ivm.net ([62.204.1.4]:24160 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553909AbQLQJoI>;
	Sun, 17 Dec 2000 01:44:08 -0800
Received: from franz.no.dom (port118.duesseldorf.ivm.de [195.247.65.118])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id KAA13625;
	Sun, 17 Dec 2000 10:43:59 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001217102118.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20001217075015.A5352@lug-owl.de>
Date:   Sun, 17 Dec 2000 10:21:18 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: FAQ/
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 17-Dec-00 Jan-Benedict Glaw wrote:
> On Sun, Dec 17, 2000 at 03:34:38AM +0100, Ralf Baechle wrote:
>> On Sun, Dec 17, 2000 at 02:29:55AM +0100, H.Heinold wrote:
>> 
>> > Hm I am still working on the boot floppies for debian, when I have the
>> > time.
>> > for mipsel they should work, but I only build them for mips.
>> > the problem on mips was the sgi disklabel, but that isnt used on dec. 
>> 
>> But SGI's don't have floppies :-)
> 
> Question in charge: Do DECstations really have floppies? Mine do
> not... So vor me it's only relevant to have an nfsroot.tgz allowing
> me to install further packages...

Besides Maxines DECstations don't have floppies. Well, there are some with SCSI
floppies but that doesn't count.

Anyway, everything that fit's on a floppy would fit into a ramdisk as well.
Compile this ramdisk image into the kernel, boot with "root=/dev/ram", et
voila...

Working on "boot floppies" *does* make sense, IMHO.

-- 
Regards,
Harald
