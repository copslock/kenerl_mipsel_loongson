Received:  by oss.sgi.com id <S553990AbRAYTZJ>;
	Thu, 25 Jan 2001 11:25:09 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:4440 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553988AbRAYTYx>;
	Thu, 25 Jan 2001 11:24:53 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com (dhcp-163-154-5-240.engr.sgi.com [163.154.5.240]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA22919
	for <linux-mips@oss.sgi.com>; Thu, 25 Jan 2001 11:23:55 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870761AbRAYR0B>; Thu, 25 Jan 2001 09:26:01 -0800
Date: 	Thu, 25 Jan 2001 09:26:01 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Justin Carlson <carlson@sibyte.com>
Cc:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
Message-ID: <20010125092601.B1026@bacchus.dhis.org>
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com> <3A6F9814.3E39027@mvista.com> <0101241917341S.00834@plugh.sibyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0101241917341S.00834@plugh.sibyte.com>; from carlson@sibyte.com on Wed, Jan 24, 2001 at 07:16:04PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 24, 2001 at 07:16:04PM -0800, Justin Carlson wrote:

> int main()
> {
> 	printf("%f\n", (float)3.14159);
> }

Note that above cast is useless; in C all floats are implicitly converted
to doubles for passing to a varargs function.

  Ralf
