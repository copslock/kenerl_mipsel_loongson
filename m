Received:  by oss.sgi.com id <S553853AbRCAQEz>;
	Thu, 1 Mar 2001 08:04:55 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:27399 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S553661AbRCAQEi>;
	Thu, 1 Mar 2001 08:04:38 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP
	id 158104C92B; Thu,  1 Mar 2001 09:04:36 -0700 (MST)
Message-ID: <3A9E7313.5090608@Lineo.COM>
Date:   Thu, 01 Mar 2001 09:04:35 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     jsun@hermes.mvista.com
Cc:     linux-mips@oss.sgi.com
Subject: Re: Patch allowing GDB to ignore misaligned data faults
References: <000a01c0a0cf$849efbe0$dde0490a@BANANA> <3A9D70C2.6010504@Lineo.COM> <3A9D793E.4063ED17@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

jsun@hermes.mvista.com wrote

> This does not sound right:  this is already fixed long time ago by not
> installing traps for exception 4&5.  What kernel are you using

You're right;  I let my patch ferment too long and it rotted.

Quinn
