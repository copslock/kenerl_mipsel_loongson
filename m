Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UJVInC000664
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 12:31:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UJVInG000663
	for linux-mips-outgoing; Thu, 30 May 2002 12:31:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UJVFnC000660
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 12:31:15 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Thu, 30 May 2002 12:32:45 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from ldt-sj3-022.sj.broadcom.com (ldt-sj3-022 [10.21.64.22])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g4UJWl1S016348 for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 12:32:47
 -0700 (PDT)
Received: (from carlson@localhost) by ldt-sj3-022.sj.broadcom.com (
 8.11.6/8.9.3) id g4UJWlv17833; Thu, 30 May 2002 12:32:47 -0700
X-Authentication-Warning: ldt-sj3-022.sj.broadcom.com: carlson set
 sender to justinca@cs.cmu.edu using -f
Subject: Function pointers and #defines
From: "Justin Carlson" <justinca@cs.cmu.edu>
To: linux-mips@oss.sgi.com
X-Mailer: Ximian Evolution 1.0.5
Date: 30 May 2002 12:32:47 -0700
Message-ID: <1022787167.14210.472.camel@ldt-sj3-022.sj.broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 10E8A1D763377-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

A fair number of places in the headers, we have stuff like this:

void (*_some_fn)(int arg1, int arg2);
#define some_fn(arg1, arg2) _some_fn(arg1, arg2)

Why do we do this, as opposed to:

void (*some_fn)(int arg1, int arg2);

Both syntaxes result in being able to say

some_fn(1, 2);

but the latter is both clearer and shorter.  Is there some deep,
mystical C reason that we use the former, or did someone do it that way
a long time ago and no one has changed it?

-Justin
