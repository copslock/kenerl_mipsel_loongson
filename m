Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 18:13:30 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.192]:55859 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225307AbVHARNP> convert rfc822-to-8bit;
	Mon, 1 Aug 2005 18:13:15 +0100
Received: by wproxy.gmail.com with SMTP id i22so1166761wra
        for <linux-mips@linux-mips.org>; Mon, 01 Aug 2005 10:16:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X8ISKrYJuhKMQqS1O2zu5FmGusFYRhV1BqG/cmfyu+gf4vmv/SORUBzeTr1oi03cXPBJVSc/nWIcAaEMD35gJASCswLqW+UvIrtQFUXmr94tlwi+h07MIX9LGNTK5pqh5b4F9C5ZeyLvenvJ1X8CnGq6y8ZI9T5h8vMfvzY+yL4=
Received: by 10.54.52.27 with SMTP id z27mr3014215wrz;
        Mon, 01 Aug 2005 10:16:15 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Mon, 1 Aug 2005 10:16:15 -0700 (PDT)
Message-ID: <2db32b720508011016537604a@mail.gmail.com>
Date:	Mon, 1 Aug 2005 10:16:15 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Kernel complaining, "eth0: Too much work in interrupt, status 8401"
Cc:	rolf liu <rolfliu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I am running linux 2.6.12 on db1550. It seems there are no many
network traffic except a few ssh sessions. Now kernel often complains
"eth0: Too much work in interrupt, status 8401".

thanks
