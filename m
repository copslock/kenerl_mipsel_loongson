Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2012 18:14:42 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:60550 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903756Ab2EBQOj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 May 2012 18:14:39 +0200
Received: by yenm7 with SMTP id m7so958579yen.36
        for <linux-mips@linux-mips.org>; Wed, 02 May 2012 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=KO3QNDFQH6LWvJzMwkTd5z6PAqp16Aehr4Tjjx6gmIc=;
        b=Pxp+OkQiJ9oTmZ+08NU0hpkQIKe1Hda9phJNCUb6XtwFREngom60u7VT3Rw0EplSG3
         EF9vO2jksDBNw2SOzoGjIEYZNsuPFAErr6ou3hywh2MSJbiYh23t7ACbCJhg55Qf9u/w
         t5ksUlSVTAMljf1L7dphUugMnGLFJbl6gveV33WuFWyWqo6o1GFx00LvtUkwtzZ2j5pQ
         PlwnKZvDGSdQceTogVBNRgMGTf20K7Q620skC4gsaLArC5fYrUHGbcOND/VSPZhaN0wz
         UxdapuGROesqxKgmpliAyTK2cUm/XlWpXAHV+CPm6gpDuTFPbfnfm7wptP/sK8+yOqll
         DxIw==
Received: by 10.236.152.41 with SMTP id c29mr18080761yhk.64.1335975273331;
 Wed, 02 May 2012 09:14:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.141.171 with HTTP; Wed, 2 May 2012 09:13:53 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
Date:   Wed, 2 May 2012 18:13:53 +0200
Message-ID: <CAOLZvyHrREz+Ya=dn4EJeHCxY-4TXsRdH6ZMwcue6K1BKZSrXg@mail.gmail.com>
Subject: NFS data corruption on 3.4
To:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello,

I'm seeing an NFS data corruption problem on 3.4-rcX kernels:
I copy the rootfs (~8 GB of data) from the DB1200 board using
NFSv3 over to another machine, and a tiny fraction of files
(~10 out of >300k) are corrupted on the target; interestingly it's
always the same ones.

In the case of /usr/bin/dbus-daemon, which is 464144 bytes in size,
bytes ranging from offset 36865 (so 32768 + 1x 4k page + 1) to 65535
are garbage, every time.

I haven't seen this with my x86/x64 machines, and also not with 3.3 or
earlier versions.

Does anyone have an idea?

Thanks!
        Manuel Lauss
