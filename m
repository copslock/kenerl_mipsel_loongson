Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7EHXNh15067
	for linux-mips-outgoing; Tue, 14 Aug 2001 10:33:23 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7EHX9j15062;
	Tue, 14 Aug 2001 10:33:10 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA05576;
	Tue, 14 Aug 2001 19:34:45 +0200 (MET DST)
Date: Tue, 14 Aug 2001 19:34:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Ralf Baechle <ralf@oss.sgi.com>, Harald Koerfgen <hkoerfg@web.de>,
   Keith Owens <kaos@ocs.com.au>, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Make __dbe_table available to modules
In-Reply-To: <3B781837.33B9E438@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010814192820.5426B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 Aug 2001, Gleb O. Raiko wrote:

> DBE is treated as ACK* on write. Some HW design manuals advise to use
> this fact even.

 And what is the use of ACK*?

 Note that that the state of the CPU at the moment of a write is
completely unrelated to the action that triggered the write.  Therefore
any reporting of a write failure is hardly useful -- possibly as a kind of
an MCE only, i.e. report the event and kill the current process or panic
if none.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
