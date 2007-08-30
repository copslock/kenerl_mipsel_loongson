Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 14:00:56 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.191]:50819 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022321AbXH3NAr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 14:00:47 +0100
Received: by fk-out-0910.google.com with SMTP id f40so367502fka
        for <linux-mips@linux-mips.org>; Thu, 30 Aug 2007 06:00:29 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OZu8hmdqLDyF8F54QRMWMItvKIOVUx7yfp1xkWPTq+Io3+W6unO9QtDQmuXsZue8lL0kw4L6sW7LLDVishpm3cjYQZ8XoFSj/irj6V9FbwMSO6SxqX6OOZgXMQiHItIXANkBqWo83X6SCL8AEw7G4IgIa4n1JdRuFDBJBecYywk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fmw4wGWvb1olX8DTPWlhRd4EmLU+hJMqyXLhix4yi1kIMZryudW4y2bCF7uEo12DUwvlMEXMO+zELmlavnjEOAjN3GHYaEVq22hMBIhZa6Pumu2i/6P6my9Xn4Q1fkMGkRVldxOGbcSzlkKCbeFsGS8p92aGSuZyq21LJcN8COk=
Received: by 10.82.178.11 with SMTP id a11mr1051921buf.1188478829574;
        Thu, 30 Aug 2007 06:00:29 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Thu, 30 Aug 2007 06:00:29 -0700 (PDT)
Message-ID: <40378e40708300600h5837d46ci5266b8ae62bbd46e@mail.gmail.com>
Date:	Thu, 30 Aug 2007 15:00:29 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Average number of instructions per line of kernel code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,
I have a question regarding the average number of assembly
instructions per line of kernel code. I know that this is a difficult
question since it depends on many factors such as the instruction set
architecture, compiler used, optimizations used, type of code, coding
style, etc...
I would like to know a rough estimate for such a quantity for the
kernel 2.4/2.6 code running on MIPS32 architecture.
My estimate is between 5-10 instructions. I googled for such a thing
but couldn't find any useful papers/resources.

Many thanks in advance.

Best regards

-- 
Mohamed A. Bamakhrama
