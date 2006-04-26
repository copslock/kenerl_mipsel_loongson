Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 05:36:39 +0100 (BST)
Received: from pproxy.gmail.com ([64.233.166.180]:56769 "EHLO pproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133403AbWDZEga (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Apr 2006 05:36:30 +0100
Received: by pproxy.gmail.com with SMTP id d80so1688181pyd
        for <linux-mips@linux-mips.org>; Tue, 25 Apr 2006 21:49:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=kyIWOFmIU/HZZz8MisF8QSHlKtL6wIoCwJN3zZOwYwAoLi1smF5UCcHsthWQjXkpIyr3PkHbsDsKlkM0spDHJLaqubKioCmGgf+z4yK5Ly+oa3qDXzp9IyNrdq64HWWhGuai+Sz//rExfDVg4+SYc7tFJNazD6/yWuDGHU/aGXg=
Received: by 10.35.103.12 with SMTP id f12mr573628pym;
        Tue, 25 Apr 2006 21:49:45 -0700 (PDT)
Received: by 10.35.96.20 with HTTP; Tue, 25 Apr 2006 21:49:45 -0700 (PDT)
Message-ID: <5800c1cc0604252149i55ab181ax7d9355a869a9b251@mail.gmail.com>
Date:	Wed, 26 Apr 2006 12:49:45 +0800
From:	"Bin Chen" <binary.chen@gmail.com>
To:	linux-mips@linux-mips.org
Subject: why not put 64 bit value directly to register
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26870_27110908.1146026985105"
Return-Path: <binary.chen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: binary.chen@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_26870_27110908.1146026985105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This code is snip from u-boot, I don't know why the 32bit-64bit conversion
is needed, why not put val directly to register but do the transform?

static void cvmx_write_cop0_entry_lo_0(uint64_t val)
{
    uint32_t val_low  =3D val & 0xffffffff;
    uint32_t val_high =3D val  >> 32;

    uint32_t tmp; /* temp register */

    asm volatile (
        "  .set mips64                       \n"
        "  .set noreorder                    \n"
        /* Standard twin 32 bit -> 64 bit construction */
        "  dsll  %[valh], 32                 \n"
        "  dla   %[tmp], 0xffffffff          \n"
        "  and   %[vall], %[tmp], %[vall]    \n"
        "  daddu %[valh], %[valh], %[vall]   \n"
        /* Combined value is in valh */
        "  dmtc0 %[valh],$2,0                \n"
        "  .set reorder                      \n"
         :[tmp] "=3D&r" (tmp) : [valh] "r" (val_high), [vall] "r" (val_low)=
 );
}

Thanks.
B.C

------=_Part_26870_27110908.1146026985105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
This code is snip from u-boot, I don't know why the 32bit-64bit
conversion is needed, why not put val directly to register but do the
transform?<br>
<br>
static void cvmx_write_cop0_entry_lo_0(uint64_t val)<br>
{<br>
&nbsp;&nbsp;&nbsp; uint32_t val_low&nbsp; =3D val &amp; 0xffffffff;<br>
&nbsp;&nbsp;&nbsp; uint32_t val_high =3D val&nbsp; &gt;&gt; 32;<br>
<br>
&nbsp;&nbsp;&nbsp; uint32_t tmp; /* temp register */<br>
<br>
&nbsp;&nbsp;&nbsp; asm volatile (<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp; .set
mips64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
\n&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp; .set
noreorder&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
\n&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Standard twin 32 bit -&gt; 64=
 bit construction */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp; dsll&nbsp; %[valh],
32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
\n&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp; dla&nbsp;&nbsp;
%[tmp],
0xffffffff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \n&quot;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp; and&nbsp;&nbsp; %[v=
all], %[tmp], %[vall]&nbsp;&nbsp;&nbsp; \n&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp; daddu %[valh], %[va=
lh], %[vall]&nbsp;&nbsp; \n&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Combined value is in valh */<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp; dmtc0
%[valh],$2,0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
\n&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp; .set
reorder&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
\n&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :[tmp] &quot;=3D&amp;r&quo=
t; (tmp) : [valh] &quot;r&quot; (val_high), [vall] &quot;r&quot; (val_low) =
);<br>
}<br>
<br>
Thanks.<br>
B.C<br>
<br>

------=_Part_26870_27110908.1146026985105--
