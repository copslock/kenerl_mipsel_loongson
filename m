Received:  by oss.sgi.com id <S42280AbQEaE0J>;
	Tue, 30 May 2000 21:26:09 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:62821 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42263AbQEaEZx>;
	Tue, 30 May 2000 21:25:53 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id VAA29732; Tue, 30 May 2000 21:12:07 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA60344
	for linux-list;
	Tue, 30 May 2000 21:10:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [163.154.34.46])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA26613;
	Tue, 30 May 2000 21:10:07 -0700 (PDT)
	mail_from (fisher@hollywood.engr.sgi.com)
Received: (from fisher@localhost) by hollywood.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id VAA00290; Tue, 30 May 2000 21:10:28 -0700 (PDT)
From:   fisher@hollywood.engr.sgi.com (William Fisher)
Message-Id: <200005310410.VAA00290@hollywood.engr.sgi.com>
Subject: Re: Problems booting Indigo...
To:     csr6702@grace.rit.edu (Chris Ruvolo)
Date:   Tue, 30 May 2000 21:10:28 -0700 (PDT)
Cc:     linux@cthulhu.engr.sgi.com, jbglaw@lug-owl.de (Jan-Benedict Glaw),
        fisher@hollywood.engr.sgi.com (William Fisher)
In-Reply-To: <Pine.LNX.4.21.0005301954120.439-100000@hork.rochester.rr.com> from "Chris Ruvolo" at May 30, 2000 08:12:53 PM
Reply-To: fisher@sgi.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> 
> On Wed, 31 May 2000, Jan-Benedict Glaw wrote:
> 
> >	  [root@parkautomat:/root] #> arp -s 192.168.1.3 08:00:69:06:BA:2E
> 
> I didn't need to do this to get the bootp response.
> 
> >	- ISC dhcpd from .deb (2.0-3) with very short config:
> 
> I switched to this and it works.
> 
> >Effect: The Indigo gets its config, but unfortunately it seems that
> >incoming tftp UDP packets are not accepted. This might be because
> >the originating port is != 69 (which is tftp):
> 
> Ok, I'm now in the same boat.
> 
> >Now the final question: How can I make in.tftpd to answer *from* port 69?
> 
> I'm not sure this is the problem.  I believe RFC-compliant TFTP servers
> use system-assigned ports for each client connection.  At least, I've seen
> this behavior on other TFTP servers.  But, you may be right.  The client
> could be expecting replies only on port 69.  I don't know if this is
> possible without modifying the TFTP server.
> 
> Can anyone confirm this?
> 
> Thanks,
> Chris
> 
> PS: Please cc responses to me.
> 
	Ok, I looked at the ARCS prom code for the Indy series machine aka an IP22
	in SGI hardware speak.

This code is from the BSD 4.3 distribution with some minor additions to support
one of the last RFC's which added a few more options to the tftp protocol.

The code in main.c looks like:


struct  servent *sp;

main(argc, argv)
        char *argv[];
{
        struct sockaddr_in sin;
        int top;

        sp = getservbyname("tftp", "udp");
        if (sp == 0) {
                fprintf(stderr, "tftp: udp/tftp: unknown service\n");
                exit(1);
        }
        f = socket(AF_INET, SOCK_DGRAM, 0);
        if (f < 0) {
                perror("tftp: socket");
                exit(3);
        }
        bzero((char *)&sin, sizeof (sin));
        sin.sin_family = AF_INET;
        if (bind(f, &sin, sizeof (sin)) < 0) {
                perror("tftp: bind");
                exit(1);
        }
        strcpy(mode, "netascii");
        signal(SIGINT, intr);
        if (argc > 1) {
                if (setjmp(toplevel) != 0)
                        exit(0);
                setpeer(argc, argv);
        }
        top = setjmp(toplevel) == 0;
        for (;;)
                command(top);
}


The socket descriptor "f" is used to receive the data from the wire.

The standard line in the /etc/services file for "tftp" contains:

tftp            69/udp

which will be returned in the "struct  servent *sp" on the "getservbyname()" call.

I looked at both tftp and tftpd and nowhere is there any checks for
the UDP packet arriving on port 69. Are you sure this is the underlying
cause of the problem? I didn't look at your packet trace in gory details.

You can look at the stand BSD 4.X release for the nearly identical source
code that is used in the SGI proms.

-- Bill (fisher@sgi.com)
