Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2015 22:35:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:57994 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010598AbbJYVfoUJMJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2015 22:35:44 +0100
X-IronPort-AV: E=Sophos;i="5.20,198,1444687200"; 
   d="scan'208";a="184387751"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 25 Oct 2015 22:35:38 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 0/1] drop unneeded of_node_get
Date:   Sun, 25 Oct 2015 22:24:24 +0100
Message-Id: <1445808265-10394-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Return-Path: <Julia.Lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Julia.Lawall@lip6.fr
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

for_each_child_of_node performs an of_node_get on each iteration, so no
of_node_get is needed on breaking out of the loop when the device_node
structure is saved in another variable.

The complete semantic match that finds this problem is
(http://coccinelle.lip6.fr):

// <smpl>
@r@
local idexpression n;
expression e1,e2;
iterator name for_each_node_by_name, for_each_node_by_type,
for_each_compatible_node, for_each_matching_node,
for_each_matching_node_and_match, for_each_child_of_node,
for_each_available_child_of_node, for_each_node_with_property;
iterator i;
statement S;
expression list [n1] es;
@@

(
(
for_each_node_by_name(n,e1) S
|
for_each_node_by_type(n,e1) S
|
for_each_compatible_node(n,e1,e2) S
|
for_each_matching_node(n,e1) S
|
for_each_matching_node_and_match(n,e1,e2) S
|
for_each_child_of_node(e1,n) S
|
for_each_available_child_of_node(e1,n) S
|
for_each_node_with_property(n,e1) S
)
&
i(es,n,...) S
)

@@
local idexpression r.n;
iterator r.i;
expression list [r.n1] es;
@@

 i(es,n,...) {
   <...
*  return (of_node_get(n));
   ...>
 }

@@
local idexpression r.n;
iterator r.i;
expression list [r.n1] es;
identifier l;
@@

 i(es,n,...) {
   ...
*  of_node_get(n)
   ...
(
   break;
|
   goto l;
|
   return ...;
)
 }
// </smpl>

---

 arch/mips/pci/pci-rt3883.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
