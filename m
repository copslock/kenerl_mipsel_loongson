Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 04:04:59 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:58140 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491952Ab0KVDE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Nov 2010 04:04:56 +0100
Received: by iwn8 with SMTP id 8so7701243iwn.36
        for <linux-mips@linux-mips.org>; Sun, 21 Nov 2010 19:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=xzyUEZce49BGW97sOMfKA4y900SSRClU+oZqqsRZobo=;
        b=vWTihsQelSYfHaY8Ezr0z7OM10y0r9az0d9QpMfhsCVgpxmCBNaULWBOZPJtbbNeN7
         pv46X97NIl1tLaQtIiBM/WymZQAT1Aoxv/kZI5WE5mvc+xL9WzhlJ8xOy3vYdTO5n8Fh
         naVZhfgcnQtJ+h/8eEviLfrkkd6f4DsWTR2KI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=kKTzJE4WKZbBNDtt60VdzicEnH2pabi4StoBM/npshgIcYeB3vYMo+Z/TQVs4KY1fo
         NZv2NqIlX42PhA8iKMSx1JiiL91o2jhB6jzNcvbskGSoZlHA+1ABYYYKGqo54BgwXii8
         +Rg4tlgMk7CbDcByuj8o4VxZhDKENxSWtQOR4=
MIME-Version: 1.0
Received: by 10.231.32.129 with SMTP id c1mr6277040ibd.60.1290395093787; Sun,
 21 Nov 2010 19:04:53 -0800 (PST)
Received: by 10.42.166.129 with HTTP; Sun, 21 Nov 2010 19:04:53 -0800 (PST)
Date:   Sun, 21 Nov 2010 22:04:53 -0500
Message-ID: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
Subject: Build failure triggered by recordmcount
From:   Arnaud Lacombe <lacombar@gmail.com>
To:     John Reiser <jreiseer@bitwagon.com>,
        Steven Rostedt <srosteedt@redhat.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <lacombar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lacombar@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

The build of an `allyesconfig' configuration from v2.6.37-rc3 is
failing relatively soon on the following:

[...]
  LD      init/mounts.o
/OpenWrt-SDK-ar71xx-for-Linux-i686/staging_dir/toolchain-mips_gcc4.1.2/bin/mips-linux-ld:
init/do_mounts.o: bad reloc symbol index (0x20200 >= 0x84) for offset
0x0 in section `__mcount_loc'

/OpenWrt-SDK-ar71xx-for-Linux-i686/staging_dir/toolchain-mips_gcc4.1.2/bin/mips-linux-ld
-v
GNU ld version 2.17

The toolchain originated from OpenWRT Kamikaze and is available on their FTP[0].

I've not been able to locate the exact point of failure.

 - Arnaud

[0]: http://downloads.openwrt.org/kamikaze/8.09.2/ar71xx/
