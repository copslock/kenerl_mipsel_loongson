Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAAgmo25544
	for linux-mips-outgoing; Mon, 10 Dec 2001 02:42:48 -0800
Received: from hypatia.brisbane.redhat.com (lulu.redhat.com.au [202.83.74.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAAgho25541;
	Mon, 10 Dec 2001 02:42:43 -0800
Received: from scooby.brisbane.redhat.com (scooby.brisbane.redhat.com [172.16.5.228])
	by hypatia.brisbane.redhat.com (8.11.6/8.11.0) with ESMTP id fBA9gVP02609;
	Mon, 10 Dec 2001 19:42:31 +1000
Received: by scooby.brisbane.redhat.com (Postfix, from userid 500)
	id 6335710810; Mon, 10 Dec 2001 20:42:31 +1100 (EST)
From: Ben Elliston <bje@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15380.33671.382927.402138@scooby.brisbane.redhat.com>
Date: Mon, 10 Dec 2001 20:42:31 +1100 (EST)
To: "H . J . Lu" <hjl@lucon.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
In-Reply-To: <15380.25324.287595.674046@scooby.brisbane.redhat.com>
References: <20011206093506.A6496@lucon.org>
	<20011206155724.A11083@dea.linux-mips.net>
	<20011206103605.A7366@lucon.org>
	<15380.25324.287595.674046@scooby.brisbane.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> "Ben" == Ben Elliston <bje@redhat.com> writes:

  Ben>   cpu=`cpp << EOF | grep ^mips

Of course, this needs some refinement.  ;-) Perhaps we need to run
through $(CC_FOR_BUILD) -E or somesuch; cpp is no good, as it won't
know all of the magic '*MIPS*' #defines.

Ben
