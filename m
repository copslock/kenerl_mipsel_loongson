Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB1NPB26087
	for linux-mips-outgoing; Mon, 10 Dec 2001 17:23:25 -0800
Received: from hypatia.brisbane.redhat.com (lulu.redhat.com.au [202.83.74.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB1NKo26060;
	Mon, 10 Dec 2001 17:23:21 -0800
Received: from scooby.brisbane.redhat.com (scooby.brisbane.redhat.com [172.16.5.228])
	by hypatia.brisbane.redhat.com (8.11.6/8.11.0) with ESMTP id fBB0N6h18612;
	Tue, 11 Dec 2001 10:23:07 +1000
Received: by scooby.brisbane.redhat.com (Postfix, from userid 500)
	id 2228A1080F; Tue, 11 Dec 2001 11:23:06 +1100 (EST)
From: Ben Elliston <bje@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15381.20970.104442.533926@scooby.brisbane.redhat.com>
Date: Tue, 11 Dec 2001 11:23:06 +1100 (EST)
To: "H . J . Lu" <hjl@lucon.org>
Cc: Daniel Jacobowitz <dan@debian.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
In-Reply-To: <20011210162028.A10675@lucon.org>
References: <20011210092104.A29953@nevyn.them.org>
	<Pine.LNX.4.33.0112110933570.17417-100000@hypatia.brisbane.redhat.com>
	<20011210162028.A10675@lucon.org>
X-Mailer: VM 6.75 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> "H" == H J Lu <hjl@lucon.org> writes:

  H> I don't want to assume $(CC_FOR_BUILD) can take - as input.

But you can assume that you're running on a MIPS Linux system.

Ben
