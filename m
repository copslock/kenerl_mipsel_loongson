Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6Ivb626767
	for linux-mips-outgoing; Thu, 6 Dec 2001 10:57:37 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB6IvXo26764
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 10:57:33 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB6HvOV11234;
	Thu, 6 Dec 2001 15:57:24 -0200
Date: Thu, 6 Dec 2001 15:57:24 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Why is byteorder removed from /proc/cpuinfo?
Message-ID: <20011206155724.A11083@dea.linux-mips.net>
References: <20011206093506.A6496@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206093506.A6496@lucon.org>; from hjl@lucon.org on Thu, Dec 06, 2001 at 09:35:06AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 06, 2001 at 09:35:06AM -0800, H . J . Lu wrote:

> The byteorder field is emoved from /proc/cpuinfo in the current 2.4
> kernel in CVS. It breaks config.guess used by all the GNU softwares.

Grrr...  In the past config.guess used gcc to compile a test program using
gcc.  I told sometime ago to whoever it was that I'm going to remove
all non-cpu related information (endianess should be considered per
_thread_ on MIPS!) from /proc/cpuinfo where it has no business; the /proc
rewrite in 2.4.15 more or less forced me into this.

  Ralf
