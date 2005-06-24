Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 23:52:16 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.197]:12877 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225526AbVFXWwB> convert rfc822-to-8bit;
	Fri, 24 Jun 2005 23:52:01 +0100
Received: by wproxy.gmail.com with SMTP id 57so1647658wri
        for <linux-mips@linux-mips.org>; Fri, 24 Jun 2005 15:51:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DO/ELCWHMu+OvgcQdlyzky7s0tJOZLm9rA+ybB/rOhDZiBONbjkBFKFJOONBKGAflWVIGlp6zhbFDuHxC3e0ZZxnFk3ulh3n78PzBitCGPyV3RQ4+MUHcbOOZbsJmQ9ENHypT5bnWFSf1gQ3TvXLE6hfPJ3UGfxJYj5W+NceSEA=
Received: by 10.54.143.4 with SMTP id q4mr2117150wrd;
        Fri, 24 Jun 2005 15:51:06 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 24 Jun 2005 15:51:06 -0700 (PDT)
Message-ID: <2db32b72050624155127a383a7@mail.gmail.com>
Date:	Fri, 24 Jun 2005 15:51:06 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: adding another PCI based serial port board causing errors on db1550
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

the driver for the board also has function "register_serial" and
"unregister_serial", which are already defined by au1x00-serial.c. So
there comes "multiple deginition" of these functions. Any idea on this
issue?

thanks
