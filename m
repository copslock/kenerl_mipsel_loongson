Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 01:14:53 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:56729 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225220AbVASBOs>;
	Wed, 19 Jan 2005 01:14:48 +0000
Received: by wproxy.gmail.com with SMTP id 69so1060357wra
        for <linux-mips@linux-mips.org>; Tue, 18 Jan 2005 17:14:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=tJ9BHfEfaFlaaSypzUzPUI1yScSsXoD7k5D4PDHmzur3RENfrMmmzwgTNdFYHXohPkNRT7fO85dbmK4lvH+i/ioMSJZpMnX7fquxDif+f3yyII/XxufvHZE0hHEKIFVVs7Jb0fLgX12MnVcyBYnNofcIuOT6KjgWdS2T0fxc4DQ=
Received: by 10.54.50.73 with SMTP id x73mr45992wrx;
        Tue, 18 Jan 2005 17:14:37 -0800 (PST)
Received: by 10.54.36.23 with HTTP; Tue, 18 Jan 2005 17:14:37 -0800 (PST)
Message-ID: <57d1eb2b050118171479cb29fa@mail.gmail.com>
Date: Wed, 19 Jan 2005 10:14:37 +0900
From: SooKang Bae <sookang.bae@gmail.com>
Reply-To: SooKang Bae <sookang.bae@gmail.com>
To: linux-mips@linux-mips.org
Subject: How do I set FCSR in assembly language(gas)?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <sookang.bae@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sookang.bae@gmail.com
Precedence: bulk
X-list: linux-mips

I want to set FCSR register with a given value.
How do I set this register in assembly language?
Would you show me an example written assembly language?
