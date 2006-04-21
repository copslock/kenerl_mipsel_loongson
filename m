Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2006 14:03:19 +0100 (BST)
Received: from wproxy.gmail.com ([64.233.184.231]:37102 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133613AbWDUNDH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2006 14:03:07 +0100
Received: by wproxy.gmail.com with SMTP id i32so374280wra
        for <linux-mips@linux-mips.org>; Fri, 21 Apr 2006 06:15:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=JJZNwkJjmSYVpgP1rCAY5r+Q6oeAnUeHrHvMzMHURPT2mXxo29LjkrV9AvmO5HHlQXCF/f626n13GL3GN9sR1Gj1mwp736xasT0rznJ/UkSQr4ZiPIW+RI8ypWjaphAHKQwLvRHMdQWY72Txcev3sHaIHX8Ynr+8NIKKnWik1rI=
Received: by 10.65.243.20 with SMTP id v20mr1011060qbr;
        Fri, 21 Apr 2006 06:15:54 -0700 (PDT)
Received: by 10.65.155.8 with HTTP; Fri, 21 Apr 2006 06:15:54 -0700 (PDT)
Message-ID: <7f0c7cce0604210615s67c3f5aegc4ee3d6541f92c67@mail.gmail.com>
Date:	Fri, 21 Apr 2006 09:15:54 -0400
From:	"Eric Gaulin" <eric.gaulin@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Au1200 MAE drivers
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11372_22360034.1145625354220"
Return-Path: <eric.gaulin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.gaulin@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_11372_22360034.1145625354220
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

We have the DbAu1200 evaluation board from AMD.

With the help of the buildroot utility  project http://buildroot.uclibc.org
we have  successfully:

- crosscompiled / booted the Linux 2.6.11-r00058 kernel sources (from AMD
which include patch for the db1200)
- crosscompiled / booted the Linux 2.6.16 kernel (vanilla sources)

Building the AMD Alchemy Au1200 MAE drivers and tools was also possible wit=
h
the same tools but when we want to start the maiplayer front end for the ma=
e
driver we get this message:

* The source tar.gz used was: amdms2-1.0-01.02.75-src.tar.gz

 MAIplayer - console-based player using MAIengine
> MAIEngine Version 3.4     BUILD V.00010275  Date 06040501
> MAIEngine result: 0x00000000 Success
> Engine Command ('help' for help):
> open "10.mp4"
> MAIEngine result: 0x00000000 Success
> Engine Command ('help' for help):
> play
>
>
>
> Trying to free free IRQ9
> Trying to free free IRQ4
> Trying to free free IRQ31
> Trying to free free IRQ1
> Trying to free free IRQ30
> open_mae_driver() version (structure size) mismatch: driver=3D0
> interface=3D200
>


According to this document 40351a_dbau1200_openemb_appnote.pdf (from AMD's
developer's website), It is possible to build en entire Linux system for
this platform using the OpenEmbedded project http://oe.handhelds.org

 AMD Have on their developer's website a tool kit for the Au1200/DbAu1200
for OpenEmbedded which is mainly a set of patches and config files for thei=
r
specifics hardware, processor and piece of software like mae drivers and a
patched 2.6.11 Linux kernel sources for au1200. (the kit used was:
au1200-dev-kit_v1.0-r3.tar.gz)

The catch is that OpenEmbedded is a very active project and a daily snapsho=
t
of the development archive is available and the older snapshots are kept fo=
r
about 30 days. The problem is the AMD's OpenEmpedded toolkit was based on a
quite old snapshot (oe_20050727083537.tgz) July 27th 2005 and most of the
patches doesn't apply anymore to the current OE snapshots.

We managed to manually  patch what is blocking the compilation of
openembedded by disabling things that aren't important four our needs and
finally we where able to boot this openembedded linux for db1200.

And we had the same poor results for the MAE Driver as we had with buildroo=
t
earlier.  (We built OE with either glibc or uclibc)

We have chosen to use OpenEmbedded for theses reasons;

   1. After requesting some "support" from AMD about how they have
   managed to compile the MAE, we where told that they use MontaVista and
   OpenEmbedded.
   2. AMD provide a precompiled demo image based on it.
   3. It is open.
   4. MontaVista preview toolkit (3.1) do not support Db1200.

* MontaVista claim that they support Db1200 with their 4.x pro version but
having tried 2 crosscompilation tool chain with the same results, we don't
want to waste money on something that would give us the same result.

I am desperately seeking help before diving into debugging this MAE thing
(wich is supposed to work)

TIA!

--
Eric Gaulin

------=_Part_11372_22360034.1145625354220
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
We have the DbAu1200 evaluation board from AMD.<br>

<br>

With the help of the buildroot utility&nbsp; project <a href=3D"http://buil=
droot.uclibc.org/" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(w=
indow,event,this)">http://buildroot.uclibc.org</a>&nbsp; we have&nbsp; succ=
essfully:&nbsp; &nbsp;  <br>




<br>

- crosscompiled / booted the Linux 2.6.11-r00058 kernel sources (from AMD w=
hich include patch for the db1200)<br>

- crosscompiled / booted the Linux 2.6.16 kernel (vanilla sources)<br>

<br>

Building the  AMD Alchemy Au1200 MAE drivers and
tools was also possible with the same tools but
when we want to start the maiplayer front end for the mae driver we get
this message:<br>



<br>

* The source tar.gz used was: amdms2-1.0-01.02.75-src.tar.gz<br>

<br>



<blockquote style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gmail_quote">
MAIplayer - console-based player using MAIengine<br>

MAIEngine Version 3.4&nbsp;&nbsp;&nbsp;&nbsp; BUILD V.00010275&nbsp; Date 0=
6040501<br>

MAIEngine result: 0x00000000 Success<br>

Engine Command ('help' for help):<br>

open &quot;10.mp4&quot;<br>

MAIEngine result: 0x00000000 Success<br>

Engine Command ('help' for help):<br>

play<br>

  <br>

  <br>

  <br>

Trying to free free IRQ9<br>

Trying to free free IRQ4<br>

Trying to free free IRQ31<br>

Trying to free free IRQ1<br>

Trying to free free IRQ30<br>

open_mae_driver() version (structure size) mismatch: driver=3D0 interface=
=3D200<br>

</blockquote>




<br>

<br>

According to this document<span> 40351a_dbau1200_openemb_appnote.pdf (from =
AMD's developer's website)</span>, It is possible to build en entire Linux =
system for this platform using the OpenEmbedded project <a href=3D"http://o=
e.handhelds.org/" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(wi=
ndow,event,this)">








http://oe.handhelds.org
</a> <br>


<br>


AMD Have on their developer's website a tool kit for the
Au1200/DbAu1200 for OpenEmbedded which is mainly a set of patches and
config files for their specifics hardware, processor and piece of
software like mae drivers and a patched 2.6.11 Linux kernel sources for
au1200. (the kit used was: au1200-dev-kit_v1.0-r3.tar.gz)<br>


<br>

The catch is that OpenEmbedded is a very active project and a daily snapsho=
t of the
development archive is available and the older snapshots are kept
for about 30 days. The problem is the AMD's OpenEmpedded toolkit was
based on a quite old snapshot (oe_20050727083537.tgz) July 27th 2005
and most of the patches doesn't apply anymore to the current OE
snapshots.<br>


<br>

We managed to manually&nbsp; patch what is blocking the compilation of
openembedded by disabling things that aren't important four our needs
and finally we where able to boot this openembedded linux for db1200.<br>
<br>
And we had the same poor results for the MAE Driver as we had with
buildroot earlier.&nbsp; (We built OE with either glibc or uclibc) <br>


<br>

We have chosen to use OpenEmbedded for theses reasons;<br>


<ol>
<li>After requesting some &quot;support&quot; from AMD about how they have
managed to compile the MAE, we where told that they use MontaVista and
OpenEmbedded.</li><li>AMD provide a precompiled demo image based on it.</li=
><li>It is open.</li><li>MontaVista preview toolkit (3.1) do not support Db=
1200.<br>
  </li>
</ol>

* MontaVista claim that they support Db1200 with their 4.x pro version
but having tried 2 crosscompilation tool chain with the same results,
we don't want to waste money on something that would give us the same
result.<br>
<br>
I am desperately seeking help before diving into debugging this MAE thing (=
wich is supposed to work)<br clear=3D"all"><br>
TIA!<br>
<br>-- <br>Eric Gaulin<br><br>

------=_Part_11372_22360034.1145625354220--
