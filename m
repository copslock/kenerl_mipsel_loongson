Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HETUs13248
	for linux-mips-outgoing; Thu, 17 Jan 2002 06:29:30 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HETQP13245
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 06:29:26 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 16RCnA-0003KU-00; Thu, 17 Jan 2002 13:41:20 +0000
Subject: Re: Compilers question
To: rabeeh@galileo.co.il (Rabeeh Khoury)
Date: Thu, 17 Jan 2002 13:41:20 +0000 (GMT)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3C45CE3B.6080507@galileo.co.il> from "Rabeeh Khoury" at Jan 16, 2002 09:02:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RCnA-0003KU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> The factors that I can identify till now are two -
> 1.. Distribute the binary in ELF format (are there any compilers that
> don't support ELF ? )
> 2.. Compile the binary that it is ABI compliant
> 
> Please add more factors that should be checked, or even suggest another 
> approach to overcome this problem (other than I get the other person 
> tool chain and compile the sources myself).

Assuming you plan to ship just the binary

3. Ensure you also either ship .o files or you avoid using libc, ld.so and any
other LGPL components (license requirements). 

4. Check you use no GPL libraries (normally not likely)

Alan
