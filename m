Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6IZ9g23601
	for linux-mips-outgoing; Thu, 6 Dec 2001 10:35:09 -0800
Received: from ocean.lucon.org ([12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB6IZ8o23598
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 10:35:08 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 91022125C1; Thu,  6 Dec 2001 09:35:06 -0800 (PST)
Date: Thu, 6 Dec 2001 09:35:06 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux-mips@oss.sgi.com
Subject: Why is byteorder removed from /proc/cpuinfo?
Message-ID: <20011206093506.A6496@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The byteorder field is emoved from /proc/cpuinfo in the current 2.4
kernel in CVS. It breaks config.guess used by all the GNU softwares.


H.J.
