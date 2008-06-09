Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 06:53:37 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:20637 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20029819AbYFIFxe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 06:53:34 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 1AD2F200A226;
	Mon,  9 Jun 2008 07:53:29 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26769-01-46; Mon, 9 Jun 2008 07:53:28 +0200 (CEST)
Received: from [192.168.10.105] (h-79-136-60-134.NA.cust.bahnhof.se [79.136.60.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id DC864200A213;
	Mon,  9 Jun 2008 07:53:27 +0200 (CEST)
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Message-Id: <20B109E2-594E-4329-95C7-F67E9A7882E2@27m.se>
From:	Markus Gothe <markus.gothe@27m.se>
To:	J.Ma <sync.jma@gmail.com>
In-Reply-To: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11-607889873"
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [SPAM] linux-2.6.25.4 Porting OOPS
Date:	Mon, 9 Jun 2008 07:53:27 +0200
References: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com>
X-Pgp-Agent: GPGMail d53 (v53, Leopard)
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.924)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-11-607889873
Content-Type: multipart/alternative; boundary=Apple-Mail-10-607889831


--Apple-Mail-10-607889831
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

Start with checking the memory mapping as hinted by:
ra    : 8000dd10 copy_user_highpage+0x98/0x158

//Markus

On 9 Jun 2008, at 05:01, J.Ma wrote:

> Hi all,
>    I am a newbie in kernel, so please be gentle.:)
>    For these days, I am working on porting linux-2.6.25.4 to my own
> Broadcom's SOC board, and I choose BCM47xx to start when menuconfig.
> Everything goes well, I ported timer, serial, flash,etc. howerver, it
> just broken when jumping to the userspace routine /sbin/init, please
> take a look at the oops dump belowed.
>    Could anyone give me a hint kindly? I doubt it might be the
> toolchain's problem(maybe syscall_exit got a invalid para), bcz the
> mipsel-linux- toolchain I used is built for linux-2.6.12. Since it
> would be a huge work to rebuild a new 2.6.25-based toolchain, I sent
> this email to check if any experienced guy could acknowledge this.
>    Thanks in advance.
>
>
>
> open /dev/console done.
> try execute_command.
> try /sbin/init.
> Data bus error, epc =3D=3D 8038c180, ra =3D=3D 8000dd10
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 10008000 fffda000 00000001
> $ 4   : 811bf000 fffda000 811bff00 fffda000
> $ 8   : 81007b20 00000044 2aaad268 2ab45c5c
> $12   : 00000248 007cd68b 2ab48f4c 004670d0
> $16   : 811bf000 80380000 7fb0a1d8 87d05a50
> $20   : 87d7c7f8 87d05a50 87cfb1a0 7fb0a1d8
> $24   : 000001b7 2aaa8a9c
> $28   : 87d78000 87d79da0 87cfb1f0 8000dd10
> Hi    : 308287f7
> Lo    : b4e07b20
> epc   : 8038c180 0x8038c180     Not tainted
> ra    : 8000dd10 copy_user_highpage+0x98/0x158
> Status: 10008003    KERNEL EXL IE
> Cause : 0080001c
> PrId  : 00020000 (Broadcom BCM4710)
> Modules linked in:
> Process init (pid: 206, threadinfo=3D87d78000, task=3D87c32df8)
> Stack : 00000000 81007b20 87d7fc28 87d05a50 00000000 81007b20 =20
> 87d7fc28 810237e0
>        800774f8 80077440 87cfb1a0 87d7c004 00000000 00000000 =20
> 00000000 00000000
>        00000000 00000000 003d969b 87d7fc28 003d969b 87d05a50 =20
> 87cfb1f0 7fb0a1d8
>        87d7c7f8 00030000 7fb0a624 80078c88 87cfb1a0 00000000 =20
> 87c32df8 802c3b0c
>        87d7c7f8 87cfb1f0 003d969b 87cfb1a0 802c35ec 00000000 =20
> 00000000 00000000
>        ...
> Call Trace:
> [<800774f8>] do_wp_page+0x58c/0x818
> [<80077440>] do_wp_page+0x4d4/0x818
> [<80078c88>] handle_mm_fault+0x778/0x86c
> [<802c3b0c>] _spin_unlock_irq+0x10/0x3c
> [<802c35ec>] __down_read+0x48/0x150
> [<8000d6f0>] do_page_fault+0x100/0x340
> [<80002a00>] ret_from_exception+0x0/0x24
> [<80002a78>] syscall_exit+0x0/0x38
>
>
> Code: cca40100  8ca80000  8ca90004 <8caa0008> 8cab000c  cc9e0100
> ac880000  ac890004  ac8a0008
> note: init[206] exited with preempt_count 2
> BUG: scheduling while atomic: init/206/0x10000002
> Call Trace:
> [<80008384>] dump_stack+0x8/0x34
> [<802c0c6c>] schedule+0x74/0x5b8
> [<80023e90>] __cond_resched+0x30/0x5c
> [<802c1304>] _cond_resched+0x4c/0x60
> [<802c2a50>] down_read+0x28/0x3c
> [<80056ecc>] acct_collect+0x48/0x1a8
> [<8002c340>] do_exit+0x2a0/0x738
> [<80008a80>] do_be+0x0/0x16c
>
> Data bus error, epc =3D=3D 8038c180, ra =3D=3D 8000dd10
> Oops[#2]:
> Cpu 0
> $ 0   : 00000000 10008000 fffda000 00000002
> $ 4   : 811c4000 fffda000 811c4f00 fffda000
> $ 8   : 81007b20 00000001 81023940 00080000
> $12   : 00000000 80386980 00000001 2ab437dc
> $16   : 811c4000 80380000 7fb0a1dc 87d05058
> $20   : 87d0a7f8 87d05058 87cfb000 7fb0a1dc
> $24   : 00000001 0046703c
> $28   : 87c18000 87c19da0 87cfb050 8000dd10
> Hi    : 308287f7
> Lo    : b4e07b20
> epc   : 8038c180 0x8038c180     Tainted: G      D
> ra    : 8000dd10 copy_user_highpage+0x98/0x158
> Status: 10008003    KERNEL EXL IE
> Cause : 0080001c
> PrId  : 00020000 (Broadcom BCM4710)
> Modules linked in:
> Process init (pid: 1, threadinfo=3D87c18000, task=3D87c16000)
> Stack : 00000000 81007b20 87d17c28 87d05058 00000000 81007b20 =20
> 87d17c28 81023880
>        800774f8 80077440 00000000 10008000 00000001 ffffffff =20
> 00000000 00000000
>        00000000 00000000 003d969b 87d17c28 003d969b 87d05058 =20
> 87cfb050 7fb0a1dc
>        87d0a7f8 00030000 7fb0a624 80078c88 000000ce 00000000 =20
> 87c16000 802c3b0c
>        87d0a7f8 87cfb050 003d969b 87cfb000 802c35ec 8001fa34 =20
> 87c18000 87c19e60
>        ...
> Call Trace:
> [<800774f8>] do_wp_page+0x58c/0x818
> [<80077440>] do_wp_page+0x4d4/0x818
> [<80078c88>] handle_mm_fault+0x778/0x86c
> [<802c3b0c>] _spin_unlock_irq+0x10/0x3c
> [<802c35ec>] __down_read+0x48/0x150
> [<8001fa34>] enqueue_task_fair+0x2c/0x44
> [<8000d6f0>] do_page_fault+0x100/0x340
> [<80027908>] do_fork+0x254/0x338
> [<800277d0>] do_fork+0x11c/0x338
> [<8001f9cc>] set_next_entity+0x28/0x64
> [<8001f9cc>] set_next_entity+0x28/0x64
> [<8001fd84>] pick_next_task_fair+0xc0/0xf0
> [<8001fdfc>] put_prev_task_fair+0x48/0x64
> [<8001fde4>] put_prev_task_fair+0x30/0x64
> [<802c1160>] schedule+0x568/0x5b8
> [<80002a00>] ret_from_exception+0x0/0x24
> [<80002b80>] work_resched+0x8/0x44
>
>
> Code: cca40100  8ca80000  8ca90004 <8caa0008> 8cab000c  cc9e0100
> ac880000  ac890004  ac8a0008
> note: init[1] exited with preempt_count 2
> Kernel panic - not syncing: Attempted to kill init!
>
>
>
> --=20
> FIXME if it is wrong.
>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com




--Apple-Mail-10-607889831
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div>Start with checking the =
memory mapping as hinted by:</div>ra &nbsp;&nbsp;&nbsp;: 8000dd10 =
copy_user_highpage+0x98/0x158<div><br></div><div>//Markus</div><div><br><d=
iv><div>On 9 Jun 2008, at 05:01, J.Ma wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div>Hi =
all,<br> &nbsp;&nbsp;&nbsp;I am a newbie in kernel, so please be =
gentle.:)<br> &nbsp;&nbsp;&nbsp;For these days, I am working on porting =
linux-2.6.25.4 to my own<br>Broadcom's SOC board, and I choose BCM47xx =
to start when menuconfig.<br>Everything goes well, I ported timer, =
serial, flash,etc. howerver, it<br>just broken when jumping to the =
userspace routine /sbin/init, please<br>take a look at the oops dump =
belowed.<br> &nbsp;&nbsp;&nbsp;Could anyone give me a hint kindly? I =
doubt it might be the<br>toolchain's problem(maybe syscall_exit got a =
invalid para), bcz the<br>mipsel-linux- toolchain I used is built for =
linux-2.6.12. Since it<br>would be a huge work to rebuild a new =
2.6.25-based toolchain, I sent<br>this email to check if any experienced =
guy could acknowledge this.<br> &nbsp;&nbsp;&nbsp;Thanks in =
advance.<br><br><br><br>open /dev/console done.<br>try =
execute_command.<br>try /sbin/init.<br>Data bus error, epc =3D=3D =
8038c180, ra =3D=3D 8000dd10<br>Oops[#1]:<br>Cpu 0<br>$ 0 &nbsp;&nbsp;: =
00000000 10008000 fffda000 00000001<br>$ 4 &nbsp;&nbsp;: 811bf000 =
fffda000 811bff00 fffda000<br>$ 8 &nbsp;&nbsp;: 81007b20 00000044 =
2aaad268 2ab45c5c<br>$12 &nbsp;&nbsp;: 00000248 007cd68b 2ab48f4c =
004670d0<br>$16 &nbsp;&nbsp;: 811bf000 80380000 7fb0a1d8 87d05a50<br>$20 =
&nbsp;&nbsp;: 87d7c7f8 87d05a50 87cfb1a0 7fb0a1d8<br>$24 &nbsp;&nbsp;: =
000001b7 2aaa8a9c<br>$28 &nbsp;&nbsp;: 87d78000 87d79da0 87cfb1f0 =
8000dd10<br>Hi &nbsp;&nbsp;&nbsp;: 308287f7<br>Lo &nbsp;&nbsp;&nbsp;: =
b4e07b20<br>epc &nbsp;&nbsp;: 8038c180 0x8038c180 =
&nbsp;&nbsp;&nbsp;&nbsp;Not tainted<br>ra &nbsp;&nbsp;&nbsp;: 8000dd10 =
copy_user_highpage+0x98/0x158<br>Status: 10008003 =
&nbsp;&nbsp;&nbsp;KERNEL EXL IE<br>Cause : 0080001c<br>PrId &nbsp;: =
00020000 (Broadcom BCM4710)<br>Modules linked in:<br>Process init (pid: =
206, threadinfo=3D87d78000, task=3D87c32df8)<br>Stack : 00000000 =
81007b20 87d7fc28 87d05a50 00000000 81007b20 87d7fc28 810237e0<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;800774f8 80077440 87cfb1a0 =
87d7c004 00000000 00000000 00000000 00000000<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00000000 00000000 003d969b =
87d7fc28 003d969b 87d05a50 87cfb1f0 7fb0a1d8<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;87d7c7f8 00030000 7fb0a624 =
80078c88 87cfb1a0 00000000 87c32df8 802c3b0c<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;87d7c7f8 87cfb1f0 003d969b =
87cfb1a0 802c35ec 00000000 00000000 00000000<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;...<br>Call =
Trace:<br>[&lt;800774f8>] do_wp_page+0x58c/0x818<br>[&lt;80077440>] =
do_wp_page+0x4d4/0x818<br>[&lt;80078c88>] =
handle_mm_fault+0x778/0x86c<br>[&lt;802c3b0c>] =
_spin_unlock_irq+0x10/0x3c<br>[&lt;802c35ec>] =
__down_read+0x48/0x150<br>[&lt;8000d6f0>] =
do_page_fault+0x100/0x340<br>[&lt;80002a00>] =
ret_from_exception+0x0/0x24<br>[&lt;80002a78>] =
syscall_exit+0x0/0x38<br><br><br>Code: cca40100 &nbsp;8ca80000 =
&nbsp;8ca90004 &lt;8caa0008> 8cab000c &nbsp;cc9e0100<br>ac880000 =
&nbsp;ac890004 &nbsp;ac8a0008<br>note: init[206] exited with =
preempt_count 2<br>BUG: scheduling while atomic: =
init/206/0x10000002<br>Call Trace:<br>[&lt;80008384>] =
dump_stack+0x8/0x34<br>[&lt;802c0c6c>] =
schedule+0x74/0x5b8<br>[&lt;80023e90>] =
__cond_resched+0x30/0x5c<br>[&lt;802c1304>] =
_cond_resched+0x4c/0x60<br>[&lt;802c2a50>] =
down_read+0x28/0x3c<br>[&lt;80056ecc>] =
acct_collect+0x48/0x1a8<br>[&lt;8002c340>] =
do_exit+0x2a0/0x738<br>[&lt;80008a80>] do_be+0x0/0x16c<br><br>Data bus =
error, epc =3D=3D 8038c180, ra =3D=3D 8000dd10<br>Oops[#2]:<br>Cpu =
0<br>$ 0 &nbsp;&nbsp;: 00000000 10008000 fffda000 00000002<br>$ 4 =
&nbsp;&nbsp;: 811c4000 fffda000 811c4f00 fffda000<br>$ 8 &nbsp;&nbsp;: =
81007b20 00000001 81023940 00080000<br>$12 &nbsp;&nbsp;: 00000000 =
80386980 00000001 2ab437dc<br>$16 &nbsp;&nbsp;: 811c4000 80380000 =
7fb0a1dc 87d05058<br>$20 &nbsp;&nbsp;: 87d0a7f8 87d05058 87cfb000 =
7fb0a1dc<br>$24 &nbsp;&nbsp;: 00000001 0046703c<br>$28 &nbsp;&nbsp;: =
87c18000 87c19da0 87cfb050 8000dd10<br>Hi &nbsp;&nbsp;&nbsp;: =
308287f7<br>Lo &nbsp;&nbsp;&nbsp;: b4e07b20<br>epc &nbsp;&nbsp;: =
8038c180 0x8038c180 &nbsp;&nbsp;&nbsp;&nbsp;Tainted: G =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D<br>ra &nbsp;&nbsp;&nbsp;: 8000dd10 =
copy_user_highpage+0x98/0x158<br>Status: 10008003 =
&nbsp;&nbsp;&nbsp;KERNEL EXL IE<br>Cause : 0080001c<br>PrId &nbsp;: =
00020000 (Broadcom BCM4710)<br>Modules linked in:<br>Process init (pid: =
1, threadinfo=3D87c18000, task=3D87c16000)<br>Stack : 00000000 81007b20 =
87d17c28 87d05058 00000000 81007b20 87d17c28 81023880<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;800774f8 80077440 00000000 =
10008000 00000001 ffffffff 00000000 00000000<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00000000 00000000 003d969b =
87d17c28 003d969b 87d05058 87cfb050 7fb0a1dc<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;87d0a7f8 00030000 7fb0a624 =
80078c88 000000ce 00000000 87c16000 802c3b0c<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;87d0a7f8 87cfb050 003d969b =
87cfb000 802c35ec 8001fa34 87c18000 87c19e60<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;...<br>Call =
Trace:<br>[&lt;800774f8>] do_wp_page+0x58c/0x818<br>[&lt;80077440>] =
do_wp_page+0x4d4/0x818<br>[&lt;80078c88>] =
handle_mm_fault+0x778/0x86c<br>[&lt;802c3b0c>] =
_spin_unlock_irq+0x10/0x3c<br>[&lt;802c35ec>] =
__down_read+0x48/0x150<br>[&lt;8001fa34>] =
enqueue_task_fair+0x2c/0x44<br>[&lt;8000d6f0>] =
do_page_fault+0x100/0x340<br>[&lt;80027908>] =
do_fork+0x254/0x338<br>[&lt;800277d0>] =
do_fork+0x11c/0x338<br>[&lt;8001f9cc>] =
set_next_entity+0x28/0x64<br>[&lt;8001f9cc>] =
set_next_entity+0x28/0x64<br>[&lt;8001fd84>] =
pick_next_task_fair+0xc0/0xf0<br>[&lt;8001fdfc>] =
put_prev_task_fair+0x48/0x64<br>[&lt;8001fde4>] =
put_prev_task_fair+0x30/0x64<br>[&lt;802c1160>] =
schedule+0x568/0x5b8<br>[&lt;80002a00>] =
ret_from_exception+0x0/0x24<br>[&lt;80002b80>] =
work_resched+0x8/0x44<br><br><br>Code: cca40100 &nbsp;8ca80000 =
&nbsp;8ca90004 &lt;8caa0008> 8cab000c &nbsp;cc9e0100<br>ac880000 =
&nbsp;ac890004 &nbsp;ac8a0008<br>note: init[1] exited with preempt_count =
2<br>Kernel panic - not syncing: Attempted to kill =
init!<br><br><br><br>-- <br>FIXME if it is =
wrong.<br><br></div></blockquote></div><br><div =
apple-content-edited=3D"true"> <span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; -webkit-border-horizontal-spacing: =
0px; -webkit-border-vertical-spacing: 0px; color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; -webkit-text-decorations-in-effect: none; =
text-indent: 0px; -webkit-text-size-adjust: auto; text-transform: none; =
orphans: 2; white-space: normal; widows: 2; word-spacing: 0px; "><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">_______________________________________</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Mr Markus =
Gothe</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Software Engineer</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Phone: =
+46 (0)13 21 81 20 (ext. 1046)</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Fax: +46 =
(0)13 21 21 15</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Mobile: +46 (0)70 348 44 =
35</div><div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: =
0px; margin-left: 0px; ">Diskettgatan 11, SE-583 35 Link=F6ping, =
Sweden</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><a =
href=3D"http://www.27m.com">www.27m.com</a></div></div><br =
class=3D"Apple-interchange-newline"></span></div></span><br =
class=3D"Apple-interchange-newline"> </div><br></div></body></html>=

--Apple-Mail-10-607889831--

--Apple-Mail-11-607889873
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkhMxVcACgkQ6I0XmJx2NryARQCfT341f3nPpY98PX3TRquWE5GC
jqcAnjONVX8rijkYvJMm7QL8CAi+pSnO
=+FXh
-----END PGP SIGNATURE-----

--Apple-Mail-11-607889873--
