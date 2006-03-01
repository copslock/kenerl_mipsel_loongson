Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 05:37:09 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:34642 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133385AbWCAFhA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 05:37:00 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 1 Mar 2006 14:44:47 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CE3E8204EB;
	Wed,  1 Mar 2006 14:44:43 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C1E68203B7;
	Wed,  1 Mar 2006 14:44:43 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k215ig4D052035;
	Wed, 1 Mar 2006 14:44:42 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 01 Mar 2006 14:44:42 +0900 (JST)
Message-Id: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: jiffies_64 vs. jiffies
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  I noticed that the 'jiffies' variable has 'wall_jiffies + 1'
value in most of time.  I'm using MIPS platform but I think this is
same for other platforms.

I suppose this is due to gcc does not know that jiffies_64 and jiffies
share same place.

In kernel/timer.c:

static inline void update_times(void)
{
	unsigned long ticks;

	ticks = jiffies - wall_jiffies;
	if (ticks) {
		wall_jiffies += ticks;
		update_wall_time(ticks);
	}
	calc_load(ticks);
}
  
void do_timer(struct pt_regs *regs)
{
	jiffies_64++;
	update_times();
	softlockup_tick(regs);
}

This is compiled MIPS code (gcc 3.4.5):

80056db4 <do_timer>:
...
80056de0:       lui     a3,0x8033
80056de4:       lw      v0,21400(a3)	# load jiffies_64(lo)
80056de8:       lui     a1,0x8033
80056dec:       lui     t1,0x8033
80056df0:       lw      a2,21400(a1)	# load jiffies
80056df4:       lw      v1,21404(a3)	# load jiffies_64(hi)
80056df8:       addiu   v0,v0,1		# inc jiffies_64(lo)
80056dfc:       lw      t0,21360(t1)	# load wall_jiffies
80056e00:       sltiu   a1,v0,1		# calc carry
80056e04:       addu    v1,v1,a1	# add carry to jiffies_64(hi)
80056e08:       subu    s4,a2,t0	# calc ticks (jiffies - wall_jiffies)
80056e0c:       sw      v0,21400(a3)	# store jiffies_64(lo)
80056e10:       sw      v1,21404(a3)	# store jiffies_64(hi)
80056e14:       beqz    s4,80057060 <do_timer+0x2ac>
80056e18:       move    s8,a0

The 'tick' variable is calculated using 'jiffies' value before
incrementing 'jiffies_64'.  As a result, wall_jiffies will always one
smaller then jiffies on elsewhere.

I also checked x86 code (3.4.4).

c012696a <do_timer>:
...
c012696e:       mov    0xc0482400,%eax	# load jiffies
c0126973:       addl   $0x1,0xc0482400	# inc jiffies_64(lo)
c012697a:       mov    0xc041a230,%edx	# load wall_jiffies
c0126980:       mov    %eax,%ebx
c0126982:       adcl   $0x0,0xc0482404	# add carry to jiffies_64(hi)
c0126989:       sub    %edx,%ebx	# calc ticks (jiffies - wall_jiffies)
c012698b:       jne    c01269a0 <do_timer+0x36>

Though I'm not familiar with x86, it looks same.

Is this really expected code?  If no, how it can be fixed?  Insert
"barrier()" right after "jiffies_64++" ?

---
Atsushi Nemoto
