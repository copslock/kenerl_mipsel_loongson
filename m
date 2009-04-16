Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Apr 2009 07:44:45 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:30110 "EHLO
	mail-bw0-f177.google.com") by ftp.linux-mips.org with ESMTP
	id S20023378AbZDPGoj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Apr 2009 07:44:39 +0100
Received: by bwz25 with SMTP id 25so254471bwz.0
        for <linux-mips@linux-mips.org>; Wed, 15 Apr 2009 23:44:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7RlUuxCAZ1UMBN+5BpuLVWWUwWuUPWvijqPNEnejBGU=;
        b=BcoqjldJTq9r49zsZ9m1YHcSewEcA5xAIZg9wj7MvpgVSUjZeOcM2tvuMQnd592mfc
         b6BMv+PHnUvEmk8Y8fGVdSxxIBIBkcGfqV3XTXXo+ZUR52KCIr5UbqDxpRqjoNdCbBNl
         n5U+PQekQL4OJ7Gg7Foq8TQmECBeuNP78CaSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BUI7Bhyccl/XRZDU00zsbBqH8oL1Bd3hCLN2zrvvwC4/CIkVpiCB5z0KV2A9ajJ34k
         E32AkHv+YKgvD9ZcnWcQuwObwpylT6SsJV+OvzYXS3ZiNVKW6DM2pnt0f72TWO0eXkOv
         uuCcfJ8ti5eLAxtxsZdJ0MT2knzDM/3XYUWh8=
MIME-Version: 1.0
Received: by 10.103.240.5 with SMTP id s5mr569115mur.133.1239864273498; Wed, 
	15 Apr 2009 23:44:33 -0700 (PDT)
In-Reply-To: <49E644A9.6040503@canonical.com>
References: <49E644A9.6040503@canonical.com>
Date:	Thu, 16 Apr 2009 08:44:33 +0200
Message-ID: <f861ec6f0904152344i781f794dkb463909d734c77f3@mail.gmail.com>
Subject: Re: Crazy idea: run linux on a mips-based photo frame
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Adilson Oliveira <adilson@canonical.com>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi!

> I have a SPF-83V photo frame from Samsung and his software (WinCE 5)
> sucks. I've being toying with the idea of running Linux on it and I
> discovered this page[1] that shows a little bit about it's guts. I have
> some experience with arm-based devices but never tried any mips-based
> one but for what I can see, the hardware is pretty standard, the SoC is
> an Alchemy AU-1200.

Shouldn't be too hard: from the debug output logs it seems to be derived from
the Db1200 (the CE-port at least).  Find out the configuration of the memory and
statis bus controllers and you should be set to run Raza's YAMON on it.

Best regards,
      Manuel Lauss
