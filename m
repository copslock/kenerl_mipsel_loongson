Received:  by oss.sgi.com id <S554040AbRAWRiV>;
	Tue, 23 Jan 2001 09:38:21 -0800
Received: from csunb0.leeds.ac.uk ([129.11.144.2]:63496 "HELO
        csunb0.leeds.ac.uk") by oss.sgi.com with SMTP id <S554030AbRAWRiE>;
	Tue, 23 Jan 2001 09:38:04 -0800
Received: from cslin.leeds.ac.uk (csunc0.leeds.ac.uk [129.11.144.3]) by csunb0.leeds.ac.uk (8.6.12/8.6.12) with ESMTP id RAA27749 for <linux-mips@oss.sgi.com>; Tue, 23 Jan 2001 17:23:31 GMT
Received: from cslin-gps.comp (cslin-gps [129.11.144.9]) by cslin.leeds.ac.uk (8.9.3+Sun/) with ESMTP id RAA15443 for <linux-mips@oss.sgi.com>; Tue, 23 Jan 2001 17:23:32 GMT
Received: from localhost by cslin-gps.comp; Tue, 23 Jan 2001 17:23:30 GMT
Date:   Tue, 23 Jan 2001 17:23:30 +0000 (GMT)
From:   Wills <wills@comp.leeds.ac.uk>
Reply-To: William Towle <wills@comp.leeds.ac.uk>
To:     linux-mips@oss.sgi.com
Subject: Re: Trying to boot an Indy
In-Reply-To: <Pine.LNX.4.30.0101231633570.2812-100000@springhead.px.uk.com>
Message-ID: <Pine.LNX.4.21.0101231656410.3184-100000@cslin-gps>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



  I am also suddenly without success:

> > > 1) I tried bootp - bootp()vmlinux - it says 'no server for vmlinux'.  The
> > > bootp server is a Linux/Alpha box running 2.4.0-ac9 - I've already done
> > > the trick with no_pmtu.  tcpdump shows bootp sending a packet with
> > > apparently the correct mac address.
> >
> > I have the same problem serving bootp from my i386 2.4.0 box. bootp
> > with kernel 2.2.x on the same box works. And it is only the bootp from
> > the command console that is failing. the bootp part later on in the
> > kernel is working from the 2.4.0 box.
> 
> This sprang into life when I added the 'sa' entry in the bootp file - that
> is the server address.

  I have a new set of IP addresses, new (2.2.18) kernel, new nfs
server utilities (all together, unfortunately) since my Indy last
spoke sanely to my intel linux box; neither the 'sa' bootptab entry
nor /proc/sys/net/ipv4/ip_no_pmtu_disc content tips have any evident
effect - ie. I will see "Setting $netaddr...", but the "obtaining
[...]" ticker no longer appears. I am eventually told, variously,
"netaddr may be set incorrectly or network too busy" or "unable to
execute bootp():vmlinux"



:(
	Wills.
