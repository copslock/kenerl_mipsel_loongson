Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2009 06:33:23 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:49014 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492332AbZJEEdS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Oct 2009 06:33:18 +0200
Received: by ewy10 with SMTP id 10so2201221ewy.33
        for <linux-mips@linux-mips.org>; Sun, 04 Oct 2009 21:33:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vkja0b6nVNazNTQLmhBok9MFipwntlPJ0m8VQ/C3TZg=;
        b=YbitVl15hEerJfwNShmQFrrijzmxY8+oosVeudT4b3K1MH13m2f5Cd9/hjYYwWvYx3
         L1bkjSxFW/fWxbvJdeiP+llXMiXS61S9tut7PlfdejOZYHSDxd6BHs49bSedvHt8ZaGR
         zvb/S6FOnvtOSFsdRz4oYIs+HGH27FegVwON8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=T5L08fZMY77k+FryaSi75JuK+G2hlyUoz7OjZ+euGtGcTQiRR19/6GQNbcDAc76SUm
         EAgGoGNWSriVt9r2hjrOHRAqvAoWj3RKlxWxdD7i7pVEUtNxCXGjhT9jJbhmiwUxH0Ji
         OtdQmZDpFTd2sbL+KG1Qn32TNiQF/lhXm+Zzg=
Received: by 10.211.139.17 with SMTP id r17mr4746090ebn.88.1254717191176;
        Sun, 04 Oct 2009 21:33:11 -0700 (PDT)
Received: from ?192.168.1.2? ([91.196.252.17])
        by mx.google.com with ESMTPS id 5sm1232225eyh.24.2009.10.04.21.33.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 21:33:09 -0700 (PDT)
From:	randrianasulu@gmail.com
To:	Toy lover <toylover@gmail.com>, linux-mips@linux-mips.org
Subject: Re: mipsel-sdelinux-v6.03.01-1.i386.rpm
Date:	Mon, 5 Oct 2009 08:31:37 +0000
User-Agent: KMail/1.9.10
References: <81f85c130910032313u532c5bdt815f0633269bf79e@mail.gmail.com>
In-Reply-To: <81f85c130910032313u532c5bdt815f0633269bf79e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200910050831.40606.randrianasulu@gmail.com>
Return-Path: <randrianasulu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrianasulu@gmail.com
Precedence: bulk
X-list: linux-mips

В сообщении от Sunday 04 October 2009 06:13:44 Toy lover написал(а):
> I am trying to compile kernel modules for a kernel compiled with
> mipsel-sdelinux-v6.03.01-1
> but the ftp://ftp.mips.com/
> pub/tools/software/sde-for-linux/v6.03.01-1/mipsel-*sdelinux*
> -v6.03.01-1.i386.rpm
> is no longer available. I am wondering whether any of you can send me a
> copy of mipsel-*sdelinux*-v6.03.01-1.i386.rpm
> which you might still own.
>
> David


I found few files here:

http://www.mvixusa.com/support/index.php?_m=downloads&_a=viewdownload&downloaditemid=50
at least 
http://files.getdropbox.com/u/397941/Ultio%20Files/Ultio%20Firmware%20and%20Sourcecode/RealTek_GPL.tar.gz
and 
http://files.getdropbox.com/u/397941/Ultio%20Files/Ultio%20Firmware%20and%20Sourcecode/Ultio%20mipsel-sdelinux-v6.03.01-1.i386.zip 
are good, working for me.

Happy hacking!
