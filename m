Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3CGgl8d010745
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 09:42:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3CGglF9010744
	for linux-mips-outgoing; Fri, 12 Apr 2002 09:42:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3CGgi8d010733
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 09:42:45 -0700
Received: from dsl73.cedar-rapids.net ([208.242.241.39] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16w48q-0008EY-00
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 11:43:16 -0500
Message-ID: <3CB71C48.B768A40D@cotw.com>
Date: Fri, 12 Apr 2002 12:41:28 -0500
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Can modules be stripped?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

For my vr5432 based board (2.4.5) I can strip and run executables.

If I strip a module, insmod dies in obj_load() with Floating point
exception.

Has anyone else seen this?

-- 
Scott A. McConnell
