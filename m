Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f71CPQw01947
	for linux-mips-outgoing; Wed, 1 Aug 2001 05:25:26 -0700
Received: from emma.patton.com (emma.patton.com [209.49.110.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f71CPPV01944
	for <linux-mips@oss.sgi.com>; Wed, 1 Aug 2001 05:25:25 -0700
Received: from patton.com (decpc.patton.com [209.49.110.83])
	by emma.patton.com (8.9.0/8.9.0) with ESMTP id IAA28096;
	Wed, 1 Aug 2001 08:25:30 -0400 (EDT)
Message-ID: <3B67F510.A0CFB4E7@patton.com>
Date: Wed, 01 Aug 2001 08:24:48 -0400
From: Paul Kasper <paul@patton.com>
Reply-To: paul@patton.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: sys_mips problems
References: <Pine.LNX.4.10.10107311435110.28897-100000@transvirtual.com>
Content-Type: multipart/mixed;
 boundary="------------111494A63E67E90551881BCC"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------111494A63E67E90551881BCC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

James Simmons wrote:
> 
> > > Since I was having problems with everything sefaulting due to the sys_mips
> > > bug I tried the patch floating around. It fixed the segfault problem but
> > > instead I get this error. Anyone knows why?
> > >
> > > : error while loading shared libraries: libc.so.6: cannot stat shared
> > > object: Error 14
> >
> > Which patch did you use?
> 
> The fast_sysmips one.
> 
> > Does your CPU have ll/sc instructions?
> 
> I have a cobalt cube which has a MIPS Nevada chip which is a R52xx chip. I
> don't know if it does. By default I have ll/sc and lld/scd instructions
> enabled.

I don't know which R52xx chip you have, but my QED RM5261 has ll/sc but
no mention of lld/scd instructions.

-- 
 /"\ . . . . . . . . . . . . . . . /"\
 \ /   ASCII Ribbon Campaign       \ /     Paul R. Kasper
  X    - NO HTML/RTF in e-mail      X      Patton Electronics Co.
 / \   - NO MSWord docs in e-mail  / \     301-975-1000 x173
--------------111494A63E67E90551881BCC
Content-Type: text/x-vcard; charset=us-ascii;
 name="paul.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Paul Kasper
Content-Disposition: attachment;
 filename="paul.vcf"

begin:vcard 
n:Kasper;Paul
tel;fax:301-869-9293
tel;work:301-975-1000 x173
x-mozilla-html:FALSE
url:www.patton.com
org:Patton Electronics Co.;Central Office Products
adr:;;7622 Rickenbacker Drive;Gaithersburg;MD;20879;USA
version:2.1
email;internet:paul@patton.com
x-mozilla-cpt:;10912
fn:Paul Kasper
end:vcard

--------------111494A63E67E90551881BCC--
