Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 16:44:00 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.203]:22137 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226263AbVGGPnl> convert rfc822-to-8bit;
	Thu, 7 Jul 2005 16:43:41 +0100
Received: by wproxy.gmail.com with SMTP id 50so224766wri
        for <linux-mips@linux-mips.org>; Thu, 07 Jul 2005 08:44:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pv0z/ZjADZLtbhS8V6xr8SBkXHzfZzG9Qkb9BcvS+FJIC39oAR/BtP+Wyl6G0Hmssw/tjxbIMNVywoenYv3DN9nofCj9ipqZLVCpnYV0BfoJ7q1wQ8wQ77Bq0JkpRIXdof91lfnCH0rMafG83j/1fCbe3I5oPP9qQs5ZrcjqeD8=
Received: by 10.54.30.4 with SMTP id d4mr865493wrd;
        Thu, 07 Jul 2005 08:44:03 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 7 Jul 2005 08:44:03 -0700 (PDT)
Message-ID: <2db32b7205070708447d967304@mail.gmail.com>
Date:	Thu, 7 Jul 2005 08:44:03 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Do I need to deal with pcmcia-cs package for linux 2.6.12 mips?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I am trying to compile the pcmcia support for db1550 based on linux
2.6.12 mips cvs head. My questions is if I need to deal with the extra
pcmcia-cs package from pcmcia-cs.sourceforge.net, or I just need to
choose the pcmcia support from `make menuconfig`?

thanks
