Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB9Jr3H11056
	for linux-mips-outgoing; Sun, 9 Dec 2001 11:53:03 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB9Jr1o11051
	for <linux-mips@oss.sgi.com>; Sun, 9 Dec 2001 11:53:01 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB8JRgU08535;
	Sat, 8 Dec 2001 17:27:42 -0200
Date: Sat, 8 Dec 2001 17:26:27 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: CVS branches
Message-ID: <20011208172627.A3385@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Some of you may already have noticed, I've created a cvs branch linux_2_4
for versions from 2.4.16 on.  The main branch has 2.5 and on.  For those
of you who are not familiar with cvs branches - when doing a checkout or
update just add the option -rlinux_2_4.  This is only necessary once as
cvs will remember on which branch you're on.  To get back to the main
branch use the option -A.  This is a slow operation so most people will
want to use separate directories for each branch.

  Ralf
