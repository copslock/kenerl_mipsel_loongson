Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UGF0J00600
	for linux-mips-outgoing; Wed, 30 May 2001 09:15:00 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UGEuh00597
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 09:14:56 -0700
Received: (qmail 7976 invoked by uid 502); 30 May 2001 16:14:50 -0000
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: linux-mips@oss.sgi.com
Subject: Toolchain patches
Date: Wed, 30 May 2001 09:14:43 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01053009144307.01259@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey people.
As we all well know, toolchain is one of major issues for Linux/MIPS.
Probably the worst one. Personally I had just gone through getting it
at least semi-straight, and blood, sweat, tears, and peaces of raw flesh
are still lying arround. I don't think I'd like my enemies to go through this.
Now, one of the reasons for this is that maintainers of some important
tools (like gcc :-) are little bit too concentrated on Inhell architecture.
They do not apply our patches, they do not fix bugs reported by us,
and in general hurt our feelings :). Of course we could start maintaining our
own trees for respective tools, but unfortunately we simply do not have
manpower right now for that (and many people would give lots of other
good arguments against this). So, I decided to put together at least
a page with collection of patches to toolchain, that didn't go into tree
to make life at least a bit easier.
Send comments, patches, and anything else, you see appropriate to me.
I hope to get initial page up in couple of days.
	Ilya.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsVHHoACgkQtKh84cA8u2k+rQCeLHzpSVBroqru0g95cyo5uJbB
askAnRmYdw28hSC06Sp/aYk1AbbTJzCX
=a6hH
-----END PGP SIGNATURE-----
