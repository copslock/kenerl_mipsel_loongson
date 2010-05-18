Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2010 07:51:01 +0200 (CEST)
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55118 "HELO
        na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491196Ab0ERFux (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 May 2010 07:50:53 +0200
Received: from source ([209.85.214.169]) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
        ID DSNKS/Iqu1gC+78MchXmvX4v3wdg7ritGSLy@postini.com; Mon, 17 May 2010 22:50:53 PDT
Received: by iwn39 with SMTP id 39so518232iwn.0
        for <linux-mips@linux-mips.org>; Mon, 17 May 2010 22:50:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.178.132 with SMTP id bm4mr1056881ibb.62.1274161850719; 
        Mon, 17 May 2010 22:50:50 -0700 (PDT)
Received: by 10.231.209.71 with HTTP; Mon, 17 May 2010 22:50:50 -0700 (PDT)
In-Reply-To: <28591517.post@talk.nabble.com>
References: <28591517.post@talk.nabble.com>
Date:   Tue, 18 May 2010 10:50:50 +0500
Message-ID: <AANLkTil1lb3R4g_1eARS8izPOboUZMlDlfRl3iHxZxcA@mail.gmail.com>
Subject: Re: Kernel not booting in QEMU_SYSTEM_MIPS
From:   adnan iqbal <adnan.iqbal@seecs.edu.pk>
To:     soumyasr <Soumya.R@kpitcummins.com>
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00504502bf637fa4100486d7ec91
Return-Path: <adnan.iqbal@seecs.edu.pk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adnan.iqbal@seecs.edu.pk
Precedence: bulk
X-list: linux-mips

--00504502bf637fa4100486d7ec91
Content-Type: text/plain; charset=ISO-8859-1

Dear soumyasr,

Below are some notes form my experience in Qemu and Mips.

---------------------------------------------------------------------------------------------------------------------------------------------------------

This document contains information about how to install qemu on linux and
Mipsel-Linux over Qemu.

Helpful links:
1.
http://www.ibm.com/developerworks/linux/library/l-qemu-development/index.html?S_TACT=105AGX03&S_CMP=HP
2.  http://www.aurel32.net/info/debian_mips_qemu.php

General sequence of installation
    download initrd.gz, already prepared disk image
    create new qemu disk
    install mips-linux on newly created qemu-disk

Command to boot an installed mipsel linux in qemu
    qemu-system-mipsel -M mips -kernel vmlinux-2.6.18-6-qemu -hda hda.img
-append "root=/dev/hda1 console=ttyS0" -nographic

I started with link 1, but mainly followed link 2 to get the working
mipsel-linux combination on qemu.

Notes:
1. the current installation does not have a running network
-- Apt get works fine
-- HTTP (wget, Lynx) does not work

2. Mounting Hard disk that works in both Host/Guest (Done)
    a. Make/download a hard disk img that may work on both host linux and
guest linux (from:
http://blog.famzah.net/2009/11/16/create-a-qemu-image-file-which-you-can-mount-in-both-linux-and-qemu/)
    b. If you want to mount it in host os (linux) then use:
        sudo mount -o loop,offset=32256 empty-ext3-2GB.img /mnt/diskimg
    c. For mounting in qemu guest os use -hdb option at boot time
        qemu-system-mipsel  -k en-us -localtime -M mips -kernel
vmlinux-2.6.18-6-qemu -hda hda.img -hdb empty-ext3-2GB.img -append
"root=/dev/hda1 console=ttyS0" -nographic
        when system boots, hard disk is available , but not mounted. It can
be mounted using
        mount /dev/hdb1 /mnt
    d. Never FORGET to unmount after use, and never use it in other OS when
being used in one.

Regards
Adnan

--00504502bf637fa4100486d7ec91
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear soumyasr,<br><br>Below are some notes form my experience in Qemu and M=
ips.<br><div id=3D":3a" class=3D"ii gt"><br>-------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------------<br>

<br>This document contains information about how to install qemu on linux a=
nd <br>Mipsel-Linux over Qemu.<br><br>Helpful links:<br>1.=A0 <a href=3D"ht=
tp://www.ibm.com/developerworks/linux/library/l-qemu-development/index.html=
?S_TACT=3D105AGX03&amp;S_CMP=3DHP">http://www.ibm.com/developerworks/linux/=
library/l-qemu-development/index.html?S_TACT=3D105AGX03&amp;S_CMP=3DHP</a><=
br>
2.=A0 <a href=3D"http://www.aurel32.net/info/debian_mips_qemu.php">http://w=
ww.aurel32.net/info/debian_mips_qemu.php</a><br><br>General sequence of ins=
tallation<br>=A0=A0=A0 download initrd.gz, already prepared disk image<br>=
=A0=A0=A0 create new qemu disk<br>
=A0=A0=A0 install mips-linux on newly created qemu-disk<br><br>Command to b=
oot an installed mipsel linux in qemu<br>=A0=A0=A0 qemu-system-mipsel -M mi=
ps -kernel vmlinux-2.6.18-6-qemu -hda hda.img -append &quot;root=3D/dev/hda=
1 console=3DttyS0&quot; -nographic<br>
<br>I started with link 1, but mainly followed link 2 to get the working mi=
psel-linux combination on qemu.<br><br>Notes:<br>1. the current installatio=
n does not have a running network<br>-- Apt get works fine<br>-- HTTP (wget=
, Lynx) does not work<br>
<br>2. Mounting Hard disk that works in both Host/Guest (Done)<br>=A0=A0=A0=
 a. Make/download a hard disk img that may work on both host linux and gues=
t linux (from: <a href=3D"http://blog.famzah.net/2009/11/16/create-a-qemu-i=
mage-file-which-you-can-mount-in-both-linux-and-qemu/">http://blog.famzah.n=
et/2009/11/16/create-a-qemu-image-file-which-you-can-mount-in-both-linux-an=
d-qemu/</a> )<br>
=A0=A0=A0 b. If you want to mount it in host os (linux) then use: <br>=A0=
=A0=A0 =A0=A0=A0 sudo mount -o loop,offset=3D32256 empty-ext3-2GB.img /mnt/=
diskimg<br>=A0=A0=A0 c. For mounting in qemu guest os use -hdb option at bo=
ot time <br>=A0=A0=A0 =A0=A0=A0 qemu-system-mipsel=A0 -k en-us -localtime -=
M mips -kernel vmlinux-2.6.18-6-qemu -hda hda.img -hdb empty-ext3-2GB.img -=
append &quot;root=3D/dev/hda1 console=3DttyS0&quot; -nographic <br>
=A0=A0=A0 =A0=A0=A0 when system boots, hard disk is available , but not mou=
nted. It can be mounted using<br>=A0=A0=A0 =A0=A0=A0 mount /dev/hdb1 /mnt<b=
r>=A0=A0=A0 d. Never FORGET to unmount after use, and never use it in other=
 OS when being used in one.<br>
<br>Regards<br>Adnan<br></div>

--00504502bf637fa4100486d7ec91--
