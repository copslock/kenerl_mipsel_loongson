Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77BqTh10500
	for linux-mips-outgoing; Tue, 7 Aug 2001 04:52:29 -0700
Received: from emma.patton.com (emma.patton.com [209.49.110.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77BqOV10479;
	Tue, 7 Aug 2001 04:52:24 -0700
Received: from patton.com (decpc.patton.com [209.49.110.83])
	by emma.patton.com (8.9.0/8.9.0) with ESMTP id HAA07874;
	Tue, 7 Aug 2001 07:52:34 -0400 (EDT)
Message-ID: <3B6FD676.CA20DF04@patton.com>
Date: Tue, 07 Aug 2001 07:52:22 -0400
From: Paul Kasper <paul@patton.com>
Reply-To: paul@patton.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: MIPS ABI (was: Changing WCHAR_TYPE from "long int" to "int"?)
References: <20010805094806.A3146@lucon.org> <20010806115913.B17179@bacchus.dhis.org> <hoofptjy6k.fsf@gee.suse.de> <997108072.1773.10.camel@ghostwheel.cygnus.com> <20010806182843.B21142@bacchus.dhis.org>
Content-Type: multipart/mixed;
 boundary="------------BD792DC6653E688B3DC63EDE"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------BD792DC6653E688B3DC63EDE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> 
> On Mon, Aug 06, 2001 at 03:27:49PM +0100, Eric Christopher wrote:
> 
> > > > The MIPS ABI defines wchar_t to long.  So please go ahead and make the
> > > > change.
> > >
> > > I'm confused.  The ABI defines it to be long - and he should change it
> > > nevertheless?
> > >
> >
> > Also depends on which MIPS ABI :)  I think it is ok to change though.
> 
> MIPS psABI 3.0.
> 
>   Ralf

Where can I find the MIPS ABI?

--
Paul K.
-- 
 /"\ . . . . . . . . . . . . . . . /"\
 \ /   ASCII Ribbon Campaign       \ /     Paul R. Kasper
  X    - NO HTML/RTF in e-mail      X      Patton Electronics Co.
 / \   - NO MSWord docs in e-mail  / \     301-975-1000 x173
--------------BD792DC6653E688B3DC63EDE
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

--------------BD792DC6653E688B3DC63EDE--
