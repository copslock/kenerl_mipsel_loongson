Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 09:35:00 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:28233 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024143AbXJPIew (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 09:34:52 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1505786nfd
        for <linux-mips@linux-mips.org>; Tue, 16 Oct 2007 01:34:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=sbYqCETdlURg+aGW1XHySGj0bIrpmc4e2RLVhrj0J1Y=;
        b=ViOnDnrRH9SJvF1FVMsNBNnYRs1g05ULBzs+jBSsvKsPaBmq278R4NGFqisqO7xctn/Q4lKaOqzjaDup69c0UpKD/QJLQgd7CN+x3eYaSBxHMRTayRUvqcWXPlc4HPXLaRlXg8VLlPZ7Nyd8dkC6b9FPXUqhaOBxV9JFJIPs9uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cxippUc1qniBvyaC4luRvFEiR4dJcJQmR57CpAJZ/dCQF+k1GaiFN6CnA+RX3+I8fD0K8TTulLvYsVaU2iwNpm6ZYUiAhe07ZIxMnLQ1GzFHDBt4Q0ynVnmLJ2h7BuY+1jxaqWt4yiBjetZfv++CroPQo64QBvL/1eUqDkuVvFE=
Received: by 10.86.33.10 with SMTP id g10mr5723454fgg.1192523691845;
        Tue, 16 Oct 2007 01:34:51 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id p9sm9720936fkb.2007.10.16.01.34.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Oct 2007 01:34:50 -0700 (PDT)
Message-ID: <4714776E.2010903@gmail.com>
Date:	Tue, 16 Oct 2007 10:33:50 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
References: <470DF25E.60009@gmail.com> <20071011124410.GA17202@linux-mips.org> <47127110.4060206@gmail.com> <20071015160109.GA11048@linux-mips.org>
In-Reply-To: <20071015160109.GA11048@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> As I recall the argumentation was they should go there because that section
> can be marked no-exec.

Are these switch tables really different from ELF .plt or .got ?

		Franck
