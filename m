Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 17:00:59 +0100 (BST)
Received: from qproxy.gmail.com ([72.14.204.204]:11040 "EHLO qproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133614AbVJRQAm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 17:00:42 +0100
Received: by qproxy.gmail.com with SMTP id q12so10157qba
        for <linux-mips@linux-mips.org>; Tue, 18 Oct 2005 09:00:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qqrxIyLIg7twgI750ynLR5UiuG+Xn5HWjJrbzPmT/mYbIP9layOlYIxm372DKWs0Tr9A+YIF8VHWvxgdgDkZIEib8bslCUCs3eMdCA0bkWCbEJBllEF1cLIaRhFPZErjc/duhhER0pW5jGaLD6U5TBL26AdCF/YXymR/NSBRpE8=
Received: by 10.65.98.20 with SMTP id a20mr3144830qbm;
        Tue, 18 Oct 2005 09:00:40 -0700 (PDT)
Received: by 10.65.97.8 with HTTP; Tue, 18 Oct 2005 09:00:40 -0700 (PDT)
Message-ID: <a59861030510180900s6041e21u@mail.gmail.com>
Date:	Tue, 18 Oct 2005 18:00:40 +0200
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	linux-mips@linux-mips.org
Subject: power management on mips
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

Hi list,

Does anyone knows what power management features are there for mips ?
I know for example that ACPI have been porting to arm. Anything
equivalent for mips ? Is it possible to do some power management under
Linux if ACPI or APM is not ported to mips ? And if yes, what would be
the work to do ?

Thanks in advance,

Ivan
