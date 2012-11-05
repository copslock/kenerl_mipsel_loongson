Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 22:23:18 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53443 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6825972Ab2KEVXPBWKAV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 22:23:15 +0100
Received: from 155.101.77.188.dynamic.jazztel.es ([188.77.101.155] helo=mail.viric.name)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1TVU8T-0007YZ-3g; Mon, 05 Nov 2012 21:23:09 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id F03892DB3A9; Mon,  5 Nov 2012 22:23:06 +0100 (CET)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 188.77.101.155
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19D+24bmnSz+NBi0Q9gIRuf
Date:   Mon, 5 Nov 2012 22:23:06 +0100
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     linux-mips@linux-mips.org
Cc:     Nikita Karetnikov <nikita.karetnikov@gmail.com>
Subject: Re: Broken readdir() since 3.5 for ext3 on mips-n32
Message-ID: <20121105212306.GO2052@vicerveza.homeunix.net>
References: <20121102183828.GX2052@vicerveza.homeunix.net>
 <20121104232119.GF2052@vicerveza.homeunix.net>
 <20121105073221.GG2052@vicerveza.homeunix.net>
 <20121105212019.GN2052@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20121105212019.GN2052@vicerveza.homeunix.net>
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 7bit
X-archive-position: 34868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viric@viric.name
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2012 at 10:20:19PM +0100, Llu=EDs Batlle i Rossell wrote:
> Hello,
>=20
> with the help of Lars on irc, we've tracked down the issue to a broken =
readdir()
> in ext3 in n32, introduced in the kernel 3.5 by this commit:
> d7dab39b6e16d5eea78ed3c705d2a2d0772b4f06
>=20
> That renders ext3 quite useless in mips n32.
>=20
> In a kernel after that commit, the example program in the 'getdents' ma=
n page
> returns this:
> [root@fu2:~/readdir]# ./getdents=20
> --------------- nread=3D116 ---------------
> i-node#  file type  d_reclen  d_off   d_name
>     3694  regular      20 1780583312  prova.c
>  1037850  regular      24 -985956880  getdents.c
>  1037848  directory    16 -1999547753  .
>  1037849  regular      20  222381689  getdents
>   778241  directory    16 -1849228342  ..
>     3647  regular      20         -1  prova
>=20
>=20
> I took Lars suggestion of applying the patch I attach (forcing ext3 to =
think it
> is a 32-bit system), and then all works. init (upstart) doesn't deadloc=
k anymore, readdir() works fine, and the getdents info looks right:
> [root@fu2:~/readdir]# ./getdents=20
> --------------- nread=3D116 ---------------
> i-node#  file type  d_reclen  d_off   d_name
>     3694  regular      20  334739480  prova.c
>  1037850  regular      24  473707228  getdents.c
>  1037848  directory    16  824759881  .
>  1037849  regular      20  875064456  getdents
>   778241  directory    16 1524836457  ..
>     3647  regular      20 2147483647  prova
>=20
> How to solve this, I don't know. But it seems that ext3 thinks that mip=
s-n32
> programs can eat some 64-bit words in d_off.

Now I add the patch I mentioned.
=20
Regards,
Llu=EDs.

--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3-n32.patch"

diff --git a/fs/ext3/dir.c b/fs/ext3/dir.c
index 92490e9..bf63d7b 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -228,6 +228,7 @@ out:
 
 static inline int is_32bit_api(void)
 {
+	return 1;
 #ifdef CONFIG_COMPAT
 	return is_compat_task();
 #else

--3siQDZowHQqNOShm--
