Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 11:50:20 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:49237 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225192AbTCaKuT>;
	Mon, 31 Mar 2003 11:50:19 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id E2AEF720; Mon, 31 Mar 2003 12:50:16 +0200 (CEST)
To: "Lyle Bainbridge" <lyle@zevion.com>
Cc: "'linux-mips'" <linux-mips@linux-mips.org>
Subject: Re: IDE initialization on AU1500?
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <000201c2f746$7fe683a0$1301a8c0@RADIUM> ("Lyle Bainbridge"'s
 message of "Sun, 30 Mar 2003 23:29:28 -0600")
References: <000201c2f746$7fe683a0$1301a8c0@RADIUM>
Date: Mon, 31 Mar 2003 12:50:16 +0200
Message-ID: <86r88n4xp3.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "lyle" == Lyle Bainbridge <lyle@zevion.com> writes:

Hi

lyle> Still, I can't explain why the scanning of non-existent hwifs was
lyle> ever done this way.  I wonder if this was rectified when the IDE
lyle> subsystem was refactored in the 2.5 kernel.  I know this new IDE
lyle> code was back ported to 2.4.21 also. Let's hope things are a done
lyle> a little bit better in this new code.

Just nick-pitting, it is the other way around:

- 2.4.X (X < 20 ide code)
- 2.4.X Andrew Hendrik code, lately adopted by Alan Cox.
- 2.5.X refactoring (jsut dropped)


Now 2.4.21-preX and 2.5.X (where X is something new), have the Andrew
Hendrik/Alan Cox IDE code.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
