Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7LNLE23918
	for linux-mips-outgoing; Fri, 7 Dec 2001 13:23:21 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7LNAo23913
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 13:23:11 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id A72F6590A9; Fri,  7 Dec 2001 15:22:07 -0500 (EST)
Message-ID: <01b801c17f5d$0af02180$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <jim@jtan.com>, "Justin Carlson" <justinca@ri.cmu.edu>
Cc: <linux-mips@oss.sgi.com>
References: <20011207121416.A9583@dev1.ltc.com> <Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be> <20011207123833.A23784@nevyn.them.org> <20011207160636.B23798@dea.linux-mips.net> <20011207131521.A3942@neurosis.mit.edu> <1007753789.1680.1.camel@GLOVEBOX.AHS.RI.CMU.EDU> <20011207144343.A4417@neurosis.mit.edu>
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence points, add const modifiers
Date: Fri, 7 Dec 2001 15:23:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----- Original Message -----
From: "Jim Paris" <jim@jtan.com>
To: "Justin Carlson" <justinca@ri.cmu.edu>
Cc: <linux-mips@oss.sgi.com>
Sent: Friday, December 07, 2001 2:43 PM
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence
points, add const modifiers


> > Maybe I missed this, but is there any reason for the patch, other then
> > a personal preference of how to do macros that look like functions?
> > I've seen gcc do strange non-optimal things with functions declared
> > inlines, but I've never seen it generate bad code WRT to do{}while(0)
> > constructs.
> >
> > Unless I'm missing something, this patch looks like a solution in search
> > of a problem...

No Justin.  See below.

> In the case of set_io_port_base, I see no real reason.  But for the
> out[b,w,l] functions, having the do/while can prevent constructs that
> might otherwise make sense, like
>
> for(i=0;i<10;i++,outb(i,port)) {
>            ...
>         }
>
> Okay, so it's a bad example, but.. :)  Maybe Brad has a better one.

>From drivers/net/wireless/heremes.h:

<snip>
/* Register access convenience macros */
#define hermes_read_reg(hw, off) (inw((hw)->iobase + (off)))
#define hermes_write_reg(hw, off, val) (outw_p((val), (hw)->iobase + (off)))

#define hermes_read_regn(hw, name) (hermes_read_reg((hw), HERMES_##name))
#define hermes_write_regn(hw, name, val) (hermes_write_reg((hw),
HERMES_##name, (val)))

/* Note that for the next two, the count is in 16-bit words, not bytes */
#define hermes_read_data(hw, off, buf, count) (insw((hw)->iobase + (off),
(buf), (count)))
#define hermes_write_data(hw, off, buf, count) (outsw((hw)->iobase + (off),
(buf), (count)))
</snip>

That won't compile with the do {...} while(0)s left in io.h.  My patch lets
hermes.h (and all other io code that I've tested) compile.

heremes.h compiles as-is on other platforms.  Why should mips snub it for
some dubious value of do {...} while(0)?

Regards,
Brad
