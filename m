Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 07:15:41 +0100 (BST)
Received: from webmail18.rediffmail.com ([IPv6:::ffff:203.199.83.28]:28500
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8224912AbUHRGPf>; Wed, 18 Aug 2004 07:15:35 +0100
Received: (qmail 31315 invoked by uid 510); 18 Aug 2004 06:15:28 -0000
Date: 18 Aug 2004 06:15:28 -0000
Message-ID: <20040818061528.31314.qmail@webmail18.rediffmail.com>
Received: from unknown (61.30.127.4) by rediffmail.com via HTTP; 18 aug 2004 06:15:28 -0000
MIME-Version: 1.0
From: "bel racu" <belracu22@rediffmail.com>
Reply-To: "bel racu" <belracu22@rediffmail.com>
To: "Arravind babu" <aravindforl@yahoo.co.in>
Cc: binutils@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: Doubt on rootfs
Content-type: multipart/alternative;
	boundary="Next_1092809728---0-203.199.83.28-31305"
Return-Path: <belracu22@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: belracu22@rediffmail.com
Precedence: bulk
X-list: linux-mips

 This is a multipart mime message


--Next_1092809728---0-203.199.83.28-31305
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; <BR>=0A<BR>=0A<BR>=0AOn Tue, 17 Aug 2004 Arravind babu wrote :=
<BR>=0A&gt;Hi all,<BR>=0A&gt;<BR>=0A&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
I am cross-compiling linux 2.4.20 onto MIPS .I compiled and i booted the sy=
stem.When i gave the command mount at the prompt it gave the following thin=
gs.<BR>=0A&gt;<BR>=0A&gt;$mount<BR>=0A&gt;<BR>=0A&gt;rootfs on / type rootf=
s (rw)<BR>=0A<BR>=0Ameen your Root filesystem is in memory<BR>=0A<BR>=0A&gt=
;/dev/rom0 on / type romfs (ro)<BR>=0A&gt;/dev/ram0 on /var type ext2 (rw)<=
BR>=0A<BR>=0ARamdisk&nbsp; mounted for /var with ext2 filesystem<BR>=0A<BR>=
=0A&gt;/proc on /proc type proc (rw)<BR>=0A<BR>=0AProcfs<BR>=0A<BR>=0A&gt;/=
dev/mtdblock6 on /flash type jffs2 (rw)<BR>=0A<BR>=0AFlash device with jffs=
2 filesystem<BR>=0A<BR>=0A&gt;/dev/ram1 on /upgrade type sramfs (rw)<BR>=0A=
&gt;/dev/mtdblock5 on /apps type cramfs (ro)<BR>=0A<BR>=0Aflash device hold=
ing ur filesystm and image<BR>=0A<BR>=0A&gt;devpts on /dev/pts type devpts =
(rw)<BR>=0A&gt;<BR>=0A&gt;<BR>=0A&gt;When i gave the same command on a norm=
al linux 2.4.20 machine i got the following.<BR>=0A&gt;<BR>=0A&gt;$mount<BR=
>=0A&gt;<BR>=0A&gt;/dev/sda1 on / type ext3 (rw)<BR>=0A&gt;none on /proc ty=
pe proc (rw)<BR>=0A&gt;usbdevfs on /proc/bus/usb type usbdevfs (rw)<BR>=0A&=
gt;none on /dev/pts type devpts (rw,gid=3D5,mode=3D620)<BR>=0A&gt;/dev/sda5=
 on /home type ext3 (rw)<BR>=0A&gt;/dev/sdb1 on /home1 type ext3 (rw)<BR>=
=0A&gt;none on /dev/shm type tmpfs (rw)<BR>=0A&gt;none on /proc/sys/fs/binf=
mt_misc type binfmt_misc (rw)<BR>=0A&gt;<BR>=0A<BR>=0Awhen u issue the Moun=
t command it will display all the mounted<BR>=0Adevices. U can also &quot;c=
at /etc/mout&quot; file to check the mounted devices<BR>=0Ain your system.<=
BR>=0A<BR>=0A<BR>=0A&gt;<BR>=0A&gt;Why rootfs is not showing any device lik=
e in linux machine( /dev/sda1 on / type ext3)&nbsp; ?<BR>=0A&gt;&nbsp; I ch=
ecked the files<BR>=0A<BR>=0A<BR>=0A&gt;usr/src/linux/init/main.c<BR>=0A&gt=
;usr/src/linux/fs/ramfs/inode.c<BR>=0A&gt;usr/src/linux/fs/namespace.c<BR>=
=0A&gt;<BR>=0A&gt;But i didnot got the point.Any idea is highly appreciated=
.My project is stopped due to this.Pls help me regarding this.<BR>=0A&gt;<B=
R>=0A&gt;Thanks in advance,<BR>=0A&gt;Aravind.<BR>=0A&gt;<BR>=0A&gt;Yahoo! =
India Matrimony: Find your life partneronline.<BR>=0A=0A</P>=0A<br><br>=0A<=
A target=3D"_blank" HREF=3D"http://clients.rediff.com/signature/track_sig.a=
sp"><IMG SRC=3D"http://ads.rediff.com/RealMedia/ads/adstream_nx.cgi/www.red=
iffmail.com/inbox.htm@Bottom" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1092809728---0-203.199.83.28-31305
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  =0A=0A=0AOn Tue, 17 Aug 2004 Arravind babu wrote :=0A>Hi all,=0A>=0A>    =
      I am cross-compiling linux 2.4.20 onto MIPS .I compiled and i booted =
the system.When i gave the command mount at the prompt it gave the followin=
g things.=0A>=0A>$mount=0A>=0A>rootfs on / type rootfs (rw)=0A=0Ameen your =
Root filesystem is in memory=0A=0A>/dev/rom0 on / type romfs (ro)=0A>/dev/r=
am0 on /var type ext2 (rw)=0A=0ARamdisk  mounted for /var with ext2 filesys=
tem=0A=0A>/proc on /proc type proc (rw)=0A=0AProcfs=0A=0A>/dev/mtdblock6 on=
 /flash type jffs2 (rw)=0A=0AFlash device with jffs2 filesystem=0A=0A>/dev/=
ram1 on /upgrade type sramfs (rw)=0A>/dev/mtdblock5 on /apps type cramfs (r=
o)=0A=0Aflash device holding ur filesystm and image=0A=0A>devpts on /dev/pt=
s type devpts (rw)=0A>=0A>=0A>When i gave the same command on a normal linu=
x 2.4.20 machine i got the following.=0A>=0A>$mount=0A>=0A>/dev/sda1 on / t=
ype ext3 (rw)=0A>none on /proc type proc (rw)=0A>usbdevfs on /proc/bus/usb =
type usbdevfs (rw)=0A>none on /dev/pts type devpts (rw,gid=3D5,mode=3D620)=
=0A>/dev/sda5 on /home type ext3 (rw)=0A>/dev/sdb1 on /home1 type ext3 (rw)=
=0A>none on /dev/shm type tmpfs (rw)=0A>none on /proc/sys/fs/binfmt_misc ty=
pe binfmt_misc (rw)=0A>=0A=0Awhen u issue the Mount command it will display=
 all the mounted=0Adevices. U can also "cat /etc/mout" file to check the mo=
unted devices=0Ain your system.=0A=0A=0A>=0A>Why rootfs is not showing any =
device like in linux machine( /dev/sda1 on / type ext3)  ?=0A>  I checked t=
he files=0A=0A=0A>usr/src/linux/init/main.c=0A>usr/src/linux/fs/ramfs/inode=
.c=0A>usr/src/linux/fs/namespace.c=0A>=0A>But i didnot got the point.Any id=
ea is highly appreciated.My project is stopped due to this.Pls help me rega=
rding this.=0A>=0A>Thanks in advance,=0A>Aravind.=0A>=0A>Yahoo! India Matri=
mony: Find your life partneronline.=0A
--Next_1092809728---0-203.199.83.28-31305--
