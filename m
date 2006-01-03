Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jan 2006 15:48:14 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:24726 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133767AbWACPrx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Jan 2006 15:47:53 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k03FoAiA015439;
	Tue, 3 Jan 2006 07:50:13 -0800
Received: from 139.95.250.1 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 03 Jan 2006 07:47:47 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k03FlkVP007317; Tue, 3
 Jan 2006 07:47:46 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 7C9192028; Tue, 3 Jan 2006
 08:47:46 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k03FslWV031984; Tue, 3 Jan 2006 08:54:47
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k03FslCm031983; Tue, 3 Jan 2006 08:54:47 -0700
Date:	Tue, 3 Jan 2006 08:54:47 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Matej Kupljen" <matej.kupljen@ultra.si>
cc:	linux-mips@linux-mips.org, linux-usb-devel@lists.sourceforge.net,
	matthias.lenk@amd.com
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
Message-ID: <20060103155447.GI15770@cosmic.amd.com>
References: <20051208210042.GB17458@cosmic.amd.com>
 <1136298329.6765.22.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1136298329.6765.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FA443292BK1531058-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

> I tried you patch, and this is what I get on 2.6.16-rc5:

Well, thats a fun one.  I'm assuming you tried to boot with a device
plugged in.  I'm a bit confused by the __reqest_region coming from
usb_create_hcd - I quickly glanced at the function, and I don't see anything
that would have called request_region / request_mem_region.  However,
there *is* a request_mem_region call immediately after the usb_create_hcd
call in usb_ehci_au1xxx_probe, and I wonder that might be the guilty party.

Matthias, any thoughts?
Jordan

--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
