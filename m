Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBA8NsA23868
	for linux-mips-outgoing; Mon, 10 Dec 2001 00:23:54 -0800
Received: from hypatia.brisbane.redhat.com (lulu.redhat.com.au [202.83.74.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBA8Nlo23864;
	Mon, 10 Dec 2001 00:23:47 -0800
Received: from scooby.brisbane.redhat.com (scooby.brisbane.redhat.com [172.16.5.228])
	by hypatia.brisbane.redhat.com (8.11.6/8.11.0) with ESMTP id fBA7NP209619;
	Mon, 10 Dec 2001 17:23:27 +1000
Received: by scooby.brisbane.redhat.com (Postfix, from userid 500)
	id 505B91080F; Mon, 10 Dec 2001 18:23:24 +1100 (EST)
From: Ben Elliston <bje@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15380.25324.287595.674046@scooby.brisbane.redhat.com>
Date: Mon, 10 Dec 2001 18:23:24 +1100 (EST)
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
   config-patches@gnu.org
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
In-Reply-To: <20011206103605.A7366@lucon.org>
References: <20011206093506.A6496@lucon.org>
	<20011206155724.A11083@dea.linux-mips.net>
	<20011206103605.A7366@lucon.org>
X-Mailer: VM 6.75 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> "H" == H J Lu <hjl@lucon.org> writes:

  >> Grrr...  In the past config.guess used gcc to compile a test program using
  >> gcc.  I told sometime ago to whoever it was that I'm going to remove
  >> all non-cpu related information (endianess should be considered per
  >> _thread_ on MIPS!) from /proc/cpuinfo where it has no business; the /proc
  >> rewrite in 2.4.15 more or less forced me into this.

  H> How about this patch?

Please, no.  I have worked very hard to eliminate many of the
instances where it has been necessary to compile dummy programs in
config.guess.  They are troublesome to many config.guess users.  How
about this instead?


  cpu=`cpp << EOF | grep ^mips
#if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL) || defined(MIPSEL)
mipsel
#endif
#if defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || defined(MIPSEB)
mips
#endif
EOF`
  if test -n "$cpu" ; then
    echo $cpu-unknown-linux-gnu && exit 0
  fi


Please try this out on a MIPS Linux system and, if it works, resubmit
a new patch along these lines.  Thanks,

Ben
