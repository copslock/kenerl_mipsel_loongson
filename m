Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Jul 2006 07:32:35 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:59498 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8126580AbWGAGc1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Jul 2006 07:32:27 +0100
Received: by ug-out-1314.google.com with SMTP id u2so987074uge
        for <linux-mips@linux-mips.org>; Fri, 30 Jun 2006 23:32:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rERT6prcNcvq/PrKyEp27HNoqLP1OxqQ7EDVggeyYTgciQM+bBDEVhycbAMbhwX+fVlmbbmGuQZuUKixzPPv+jgnGrxWafd3hdFAeSiIiAToPWRLtFVSeulYz/WBc9LFE8yh46HkPKMQc4b/OoYhasK5pWw7cKgjawGBTdVAmsk=
Received: by 10.78.179.12 with SMTP id b12mr299388huf;
        Fri, 30 Jun 2006 23:32:26 -0700 (PDT)
Received: by 10.78.83.7 with HTTP; Fri, 30 Jun 2006 23:32:26 -0700 (PDT)
Message-ID: <f69849430606302332g227bbb51n5aec43d08f2886eb@mail.gmail.com>
Date:	Sat, 1 Jul 2006 11:32:26 +0500
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	gcc@gcc.gnu.org, gcc-help@gcc.gnu.org, linux-mips@linux-mips.org
Subject: explaination of some gcc functions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
     I'm trying to understand the backend code of gcc for MIPS
architecture.I'm having some trouble while understanding following
functions.

1:  push_topmost_sequence();
2: emit_insn_after(seq,get_insns());
3: pop_topmost_sequence();
4: emit_insn_before

Would you please explain what's the role of each function.
