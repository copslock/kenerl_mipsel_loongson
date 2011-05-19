Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 20:54:28 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:53308 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491066Ab1ESSyX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2011 20:54:23 +0200
Received: by pzk28 with SMTP id 28so1550243pzk.36
        for <multiple recipients>; Thu, 19 May 2011 11:54:16 -0700 (PDT)
Received: by 10.143.26.26 with SMTP id d26mr2150205wfj.176.1305831256207;
        Thu, 19 May 2011 11:54:16 -0700 (PDT)
Received: from localhost ([70.72.87.49])
        by mx.google.com with ESMTPS id p40sm2528617wfc.7.2011.05.19.11.54.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2011 11:54:14 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id B06FE1811AC; Thu, 19 May 2011 12:54:13 -0600 (MDT)
Date:   Thu, 19 May 2011 12:54:13 -0600
From:   Grant Likely <grant.likely@secretlab.ca>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/6] of: Make of_find_node_by_path() traverse
 /aliases for relative paths.
Message-ID: <20110519185413.GE5109@ponder.secretlab.ca>
References: <1304614949-30460-1-git-send-email-ddaney@caviumnetworks.com>
 <1304614949-30460-3-git-send-email-ddaney@caviumnetworks.com>
 <4DC3C7FC.9050807@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DC3C7FC.9050807@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Fri, May 06, 2011 at 02:05:48PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 05-05-2011 21:02, David Daney wrote:
> 
> >Currently all paths passed to of_find_node_by_path() must begin with a
> >'/', indicating a full path to the desired node.
> 
> >Augment the look-up code so that if a path does *not* begin with '/',
> >the path is used as the name of an /aliases property.  The value of
> >this alias is then used as the full node path to be found.
> 
> >Signed-off-by: David Daney<ddaney@caviumnetworks.com>
> >---
> >  drivers/of/base.c |   41 ++++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 40 insertions(+), 1 deletions(-)
> 
> >diff --git a/drivers/of/base.c b/drivers/of/base.c
> >index 632ebae..1a0a83e 100644
> >--- a/drivers/of/base.c
> >+++ b/drivers/of/base.c
> [...]
> >@@ -348,14 +351,50 @@ EXPORT_SYMBOL(of_get_next_child);
> >  struct device_node *of_find_node_by_path(const char *path)
> >  {
> >  	struct device_node *np = allnodes;
> >+	struct device_node *aliases = NULL;
> >+	char *alias = NULL;
> >+	char *new_path = NULL;
> >
> >  	read_lock(&devtree_lock);
> >+
> >+	if (path[0] != '/') {
> >+		const char *ps;
> >+		aliases = of_find_node_by_path("/aliases");
> >+		if (!aliases)
> >+			goto out;
> >+
> >+		ps = strchr(path, '/');
> >+		if (ps) {
> >+			size_t len = ps - path;
> >+			alias = kmalloc(len + 1, GFP_KERNEL);
> 
>    How about error handling?

Yes, please add error handling and repost.

Thanks,
g.
