Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 11:28:09 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:33431 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492153Ab0A2K2C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2010 11:28:02 +0100
Received: by pwj1 with SMTP id 1so1260101pwj.24
        for <linux-mips@linux-mips.org>; Fri, 29 Jan 2010 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=+qnQH6aYtgzzPAlldCRtjAxyAkvm54/4OIaqI7iQRcQ=;
        b=A7pcf3YcufAbd8sUySIx7LuAgkHX7FYebW+K4UXmShZaNyqaCOOPqdua4IXAhdfH9H
         dmtifFOa493aBP510vwyYzC0OJzu4oeh8A0g3DgW3Gp6z2q5QicagrUaxA4CuIj1J7dx
         qu03vVTYE2zhBVq3jrxsVIaN+6YI+cUTGQIJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Bx34UVQLh1XIXN0H0TUlZC6p8051MFlosekTcu6uJpZ0hlg4oN167y7B7aoFiNSNJF
         SJHBApC7TkkPMQd2U8OEkvxXxKmBVxJdsr348xDaoqETfSjquEAmPoNGtcQRRlUtaqRV
         Mwo6eA2UxJfVQvIGizSBQIPKkrnDk8rrKaE2s=
MIME-Version: 1.0
Received: by 10.140.82.42 with SMTP id f42mr447289rvb.163.1264760873554; Fri, 
        29 Jan 2010 02:27:53 -0800 (PST)
Date:   Fri, 29 Jan 2010 19:27:53 +0900
Message-ID: <38dc7fce1001290227v746c0a3dp4b3d81a58e73cf83@mail.gmail.com>
Subject: GCC 4.4.2(mips) with -mplt option
From:   YD <ydgoo9@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 25732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18760

Hello,

I have built the toolchain using the buildroot ( GCC 4.4.2 with
uClibc-0.9.30.1 )

Everything works well but when I compiled with -mplt option, always it
fails with Segmentation fault.

I read some articles that with -mplt option, preformance will be 10%
highter than without plt option.

I don't know why this fails everytime. please help me...

#include <stdio.h>
int main()
{
 printf("Hello world \n"); return 0;
}

#mipsel-linux-gcc  -o a a.c
 Hello world
#mipsel-linux-gcc -mplt -o a a.c
 Segmentation fault
#mipsel-linux-gcc -mplt -no-shared -o a a.c
 Segmentation fault
#mipsel-linux-gcc -mplt -no-shared -mabicalls -o a a.c
 Segmentation fault

Thanks,
