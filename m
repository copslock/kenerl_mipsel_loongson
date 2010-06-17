Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 14:21:04 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:38606 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491898Ab0FQMVA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 14:21:00 +0200
Received: by pwj6 with SMTP id 6so4761795pwj.36
        for <multiple recipients>; Thu, 17 Jun 2010 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=AKgXbGSU5hFTtpWMkUHnqKs0wz8z35JpQxoDFeam3H0=;
        b=x4rJrSvdE8PWMFgZWW3Bme1ZpQkFae3ySjAddURRQ0IelbatBLeHpu/dfJnJBs7MG8
         I7z0s+sFR/KHFFYhxlj3krj0lc1Vi0RiXc+s3hkz5XNwmdoD2IdfP4NYlhyGgwt+PaBP
         tGFln+f9mNUyV5ThZknhXlizNNVBEP02aSI3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=C6+dwBUgiywIL44BxFfFayHwzbStufA1ZVSaTkJ7Opqd6Np2gZM63/VlKb6c1bfggZ
         7WK49P5jkL1hcCXjLw7SmTuqfwbl2AxFqDlSHjANrfmAtZTYlJOMUXy6gqFez0yDxq6s
         fH3WLcqoX06DnQ5VkKeVm82AJSLW9ZaN29xvo=
MIME-Version: 1.0
Received: by 10.143.24.24 with SMTP id b24mr7296039wfj.180.1276777249942; Thu, 
        17 Jun 2010 05:20:49 -0700 (PDT)
Received: by 10.142.211.16 with HTTP; Thu, 17 Jun 2010 05:20:49 -0700 (PDT)
In-Reply-To: <1276179278.21482.16.camel@localhost>
References: <20100609153831.GA27461@waldemar-brodkorb.de>
        <1276099374.4510.13.camel@localhost>
        <20100609172438.GA23116@waldemar-brodkorb.de>
        <1276179278.21482.16.camel@localhost>
Date:   Thu, 17 Jun 2010 20:20:49 +0800
Message-ID: <AANLkTikZc02RQ2zJ4Cj0nxUezYXyVIMxQS2opAWSjOrd@mail.gmail.com>
Subject: Re: zboot for brcm
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Waldemar Brodkorb <mail@waldemar-brodkorb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11985

Hi,

I just got a bcm1250a board, it also uses the CFE as the bootloader, I
compiled a compressed vmlinuz-2.6.34 for it and boot with the
following command, it works well:

CFE> setenv bootargs root=/dev/nfs rw
nfsroot=$nfs_server_ip:/path/to/nfs_root_fs ip=dhcp
CFE> ifconfig -auto eth0
CFE> boot -elf $tftp_server_ip:/path/to/vmlinuz

With -elf, the boot command of CFE can parse the vmlinuz and boot it
normally. I think you have used the wrong options of the boot command.

Regards,

-- 
Studying engineer. Wu Zhangjin
Lanzhou University      http://www.lzu.edu.cn
Distributed & Embedded System Lab      http://dslab.lzu.edu.cn
School of Information Science and Engeneering         http://xxxy.lzu.edu.cn
wuzhangjin@gmail.com         http://falcon.oss.lzu.edu.cn
Address:Tianshui South Road 222,Lanzhou,P.R.China    Zip Code:730000
Tel:+86-931-8912025
