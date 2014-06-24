Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 17:48:47 +0200 (CEST)
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:34349 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6816071AbaFXPsnVBoC- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 17:48:43 +0200
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1386B29DE18;
        Tue, 24 Jun 2014 15:48:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grass47_85d685a7bac2a
X-Filterd-Recvd-Size: 1675
Received: from [192.168.1.162] (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Jun 2014 15:48:39 +0000 (UTC)
Message-ID: <1403624918.29061.16.camel@joe-AO725>
Subject: Re: [PATCH 1/1] ar7: replace mac address parsing
From:   Joe Perches <joe@perches.com>
To:     Daniel Walter <dwalter@google.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Jun 2014 08:48:38 -0700
In-Reply-To: <20140624153959.GA19564@google.com>
References: <20140624153959.GA19564@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 2014-06-24 at 16:39 +0100, Daniel Walter wrote:
> Replace sscanf() with mac_pton().
[]
> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
[]
> @@ -307,10 +307,7 @@ static void __init cpmac_get_mac(int instance, unsigned char *dev_addr)
>  	}
>  
>  	if (mac) {
> -		if (sscanf(mac, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
> -					&dev_addr[0], &dev_addr[1],
> -					&dev_addr[2], &dev_addr[3],
> -					&dev_addr[4], &dev_addr[5]) != 6) {
> +		if (!mac_pton(mac, dev_addr)) {

There is a slight functional change with this conversion.

mac_pton is strict about leading 0's and requires a 17 char strlen.

sscanf will accept 0:1:2:3:4:5, mac_pton will not.

>  			pr_warning("cannot parse mac address, "
>  					"using random address\n");

could be coalesced and pr_warn

			pr_warn("cannot parse mac address - using random address\n");
