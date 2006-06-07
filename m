Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 13:56:46 +0100 (BST)
Received: from qb-out-0506.google.com ([72.14.204.225]:20655 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133677AbWFGM4j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 13:56:39 +0100
Received: by qb-out-0506.google.com with SMTP id e12so141694qbe
        for <linux-mips@linux-mips.org>; Wed, 07 Jun 2006 05:56:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sTfr7sQddnf0H3rCbjTINVLpvZgcQBWV0rJ+DbGiNHbzOlTetfqF7imb52SQxnkp15G/uTs8s0Dp7p8yIOt/ez0f2yLDYoVk08eOskt6Fi7MWIZr+h95HgHeUSPHftypWy8S7JMFZfZp8TBA1YmoAdy2OUlIN2pUiHI1jji6gzA=
Received: by 10.70.29.3 with SMTP id c3mr666332wxc;
        Wed, 07 Jun 2006 05:56:37 -0700 (PDT)
Received: by 10.70.89.6 with HTTP; Wed, 7 Jun 2006 05:56:37 -0700 (PDT)
Message-ID: <f69849430606070556hb60fa66m50c58a93667e368b@mail.gmail.com>
Date:	Wed, 7 Jun 2006 17:56:37 +0500
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: RTL explaination
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
I'm trying to understand the rtl genrated by gcc for mips processor.I
have read gcc internals by Richard Stallman but there  are still some
confusions in the rtl language.

Following is a snippet of code which i'm trying to understand.

(insn 9 6 10 (nil) (set (reg:SI 182)
        (mem/f:SI (symbol_ref:SI ("a")) [0 a+0 S4 A32])) -1 (nil)
    (nil))

In the above code following part is still unclear to me

[0 a+0 S4 A32])) -1 (nil)
    (nil))

Following is the c code for which above rtl is generated :

int a;
main()
{
a=a+1;
}


thanks,
shahzad
