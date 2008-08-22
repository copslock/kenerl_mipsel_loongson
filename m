Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 13:04:49 +0100 (BST)
Received: from eir.is.scarlet.be ([193.74.71.27]:33206 "EHLO eir.is.scarlet.be")
	by ftp.linux-mips.org with ESMTP id S20033846AbYHVMEk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 13:04:40 +0100
Received: from scarlet.be (taj.is.scarlet.be [193.74.71.42])
	by eir.is.scarlet.be (8.14.2/8.14.2) with ESMTP id m7MC4aY7005427;
	Fri, 22 Aug 2008 14:04:36 +0200
Date:	Fri, 22 Aug 2008 13:04:36 +0100
Message-Id: <K6047O$07C3A675C0E02FC7BE973C0D5DEF9AAA@scarlet.be>
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: multipart/mixed; boundary="_=__=_XaM3_.1219406676.2A.885565.42.15885.52.42.007.184490982"
From:	"Joel Soete" <soete.joel@scarlet.be>
To:	"tiwai" <tiwai@suse.de>
Cc:	"James\.Bottomley" <James.Bottomley@HansenPartnership.com>,
	"linux-mips" <linux-mips@linux-mips.org>,
	"ralf" <ralf@linux-mips.org>,
	"linux-parisc" <linux-parisc@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B54)
X-type:	0
X-SenderIP: 57.67.177.33
X-DCC-scarlet.be-Metrics: eir; whitelist
Return-Path: <soete.joel@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <K6047O$07C3A675C0E02FC7BE973C0D5DEF9AAA
Envelope-Id: <K6047O$07C3A675C0E02FC7BE973C0D5DEF9AAA
X-archive-position: 20325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: soete.joel@scarlet.be
Precedence: bulk
X-list: linux-mips

--_=__=_XaM3_.1219406676.2A.885565.42.15885.52.42.007.184490982
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Takashi et al.,

[snip]

> diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
> index b30e38f..dd2ab2c 100644
> --- a/drivers/parisc/ccio-dma.c
> +++ b/drivers/parisc/ccio-dma.c
> @@ -1014,6 +1014,19 @@ ccio_unmap_sg(struct device *dev, struct scatter=
list
*sglist, int nents,
>  	DBG_RUN_SG("%s() DONE (nents %d)\n", __func__, nents);
>  }
>  
> +static int ccio_dma_mmap_coherent(struct device *dev,
> +				  struct vm_area_struct *vma,
> +				  void *cpu_addr, dma_addr_t handle,
> +				  size_t size)
> +{
> +	struct page *pg;
> +	pgprot_val(vma->vm_page_prot) |=3D _PAGE_NO_CACHE;
> +	pg =3D virt_to_page(cpu_addr);
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       page_to_pfn(pg) + vma->vm_pgoff,
> +			       size, vma->vm_page_prot);
> +}
> +
>  static struct hppa_dma_ops ccio_ops =3D {
>  	.dma_supported =3D	ccio_dma_supported,
>  	.alloc_consistent =3D	ccio_alloc_consistent,
> @@ -1027,6 +1040,7 @@ static struct hppa_dma_ops ccio_ops =3D {
>  	.dma_sync_single_for_device =3D	NULL,	/* NOP for U2/Uturn */
>  	.dma_sync_sg_for_cpu =3D		NULL,	/* ditto */
>  	.dma_sync_sg_for_device =3D		NULL,	/* ditto */
> +	.mmap_coherent =3D	ccio_dma_mmap_coherent,
>  };
>  
>  #ifdef CONFIG_PROC_FS
> diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
> index bc73b96..403d66d 100644
> --- a/drivers/parisc/sba_iommu.c
> +++ b/drivers/parisc/sba_iommu.c
> @@ -1057,6 +1057,19 @@ sba_unmap_sg(struct device *dev, struct scatterl=
ist
*sglist, int nents,
>  
>  }
>  
> +static int sba_dma_mmap_coherent(struct device *dev,
> +				 struct vm_area_struct *vma,
> +				 void *cpu_addr, dma_addr_t handle,
> +				 size_t size)
> +{
> +	struct page *pg;
> +	pgprot_val(vma->vm_page_prot) |=3D _PAGE_NO_CACHE;
> +	pg =3D virt_to_page(cpu_addr);
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       page_to_pfn(pg) + vma->vm_pgoff,
> +			       size, vma->vm_page_prot);
> +}
> +
>  static struct hppa_dma_ops sba_ops =3D {
>  	.dma_supported =3D	sba_dma_supported,
>  	.alloc_consistent =3D	sba_alloc_consistent,
> @@ -1070,6 +1083,7 @@ static struct hppa_dma_ops sba_ops =3D {
>  	.dma_sync_single_for_device =3D	NULL,
>  	.dma_sync_sg_for_cpu =3D		NULL,
>  	.dma_sync_sg_for_device =3D	NULL,
> +	.mmap_coherent =3D	sba_dma_mmap_coherent,
>  };
> 
I build and boot successfully kernel 32bit including your patch on 2 syst=
ems
(a b2k using sba and a d380 using ccio).

I just noticed that the above code is ~ the same; otoh there is also a
iommu-helpers.h containing also common code to those 2 drivers. So may be=
 for
easiest maintenance, could you merge and move this code in this 'helper' =
as
follow:
--- ./drivers/parisc/iommu-helpers.h.Orig	2008-08-01 12:57:22.000000000 +=
0000
+++ ./drivers/parisc/iommu-helpers.h	2008-08-22 08:07:26.000000000 +0000
@@ -172,3 +172,16 @@
 	return n_mappings;
 }
 
+static int iommu_dma_mmap_coherent(struct device *dev,
+				  struct vm_area_struct *vma,
+				  void *cpu_addr, dma_addr_t handle,
+				  size_t size)
+{
+	struct page *pg;
+	pgprot_val(vma->vm_page_prot) |=3D _PAGE_NO_CACHE;
+	pg =3D virt_to_page(cpu_addr);
+	return remap_pfn_range(vma, vma->vm_start,
+			       page_to_pfn(pg) + vma->vm_pgoff,
+			       size, vma->vm_page_prot);
+}
+
--- ./drivers/parisc/ccio-dma.c.Orig	2008-08-22 07:49:21.000000000 +0000
+++ ./drivers/parisc/ccio-dma.c	2008-08-22 08:06:32.000000000 +0000
@@ -1005,19 +1005,6 @@
 	DBG_RUN_SG("%s() DONE (nents %d)\n", __func__, nents);
 }
 
-static int ccio_dma_mmap_coherent(struct device *dev,
-				  struct vm_area_struct *vma,
-				  void *cpu_addr, dma_addr_t handle,
-				  size_t size)
-{
-	struct page *pg;
-	pgprot_val(vma->vm_page_prot) |=3D _PAGE_NO_CACHE;
-	pg =3D virt_to_page(cpu_addr);
-	return remap_pfn_range(vma, vma->vm_start,
-			       page_to_pfn(pg) + vma->vm_pgoff,
-			       size, vma->vm_page_prot);
-}
-
 static struct hppa_dma_ops ccio_ops =3D {
 	.dma_supported =3D	ccio_dma_supported,
 	.alloc_consistent =3D	ccio_alloc_consistent,
@@ -1031,7 +1018,7 @@
 	.dma_sync_single_for_device =3D	NULL,	/* NOP for U2/Uturn */
 	.dma_sync_sg_for_cpu =3D		NULL,	/* ditto */
 	.dma_sync_sg_for_device =3D		NULL,	/* ditto */
-	.mmap_coherent =3D	ccio_dma_mmap_coherent,
+	.mmap_coherent =3D	iommu_dma_mmap_coherent,
 };
 
 #ifdef CONFIG_PROC_FS
--- ./drivers/parisc/sba_iommu.c.Orig	2008-08-22 07:49:21.000000000 +0000=

+++ ./drivers/parisc/sba_iommu.c	2008-08-22 08:08:30.000000000 +0000
@@ -1057,19 +1057,6 @@
 
 }
 
-static int sba_dma_mmap_coherent(struct device *dev,
-				 struct vm_area_struct *vma,
-				 void *cpu_addr, dma_addr_t handle,
-				 size_t size)
-{
-	struct page *pg;
-	pgprot_val(vma->vm_page_prot) |=3D _PAGE_NO_CACHE;
-	pg =3D virt_to_page(cpu_addr);
-	return remap_pfn_range(vma, vma->vm_start,
-			       page_to_pfn(pg) + vma->vm_pgoff,
-			       size, vma->vm_page_prot);
-}
-
 static struct hppa_dma_ops sba_ops =3D {
 	.dma_supported =3D	sba_dma_supported,
 	.alloc_consistent =3D	sba_alloc_consistent,
@@ -1083,7 +1070,7 @@
 	.dma_sync_single_for_device =3D	NULL,
 	.dma_sync_sg_for_cpu =3D		NULL,
 	.dma_sync_sg_for_device =3D	NULL,
-	.mmap_coherent =3D	sba_dma_mmap_coherent,
+	.mmap_coherent =3D	iommu_dma_mmap_coherent,
 };
 
 
=3D=3D=3D <> =3D=3D=3D  
>  
> diff --git a/include/asm-parisc/dma-mapping.h b/include/asm-parisc/dma-=
mapping.h
> index 53af696..5b357b3 100644
> --- a/include/asm-parisc/dma-mapping.h
> +++ b/include/asm-parisc/dma-mapping.h

The small issue encountered: against latest Kyle git tree (dated 2008-07-=
29)
this file was moved in arch/parisc/include/asm.

> @@ -19,6 +19,9 @@ struct hppa_dma_ops {
>  	void (*dma_sync_single_for_device)(struct device *dev, dma_addr_t iov=
a,
unsigned long offset, size_t size, enum dma_data_direction direction);
>  	void (*dma_sync_sg_for_cpu)(struct device *dev, struct scatterlist *s=
g,
int nelems, enum dma_data_direction direction);
>  	void (*dma_sync_sg_for_device)(struct device *dev, struct scatterlist=
 *sg,
int nelems, enum dma_data_direction direction);
> +	int (*mmap_coherent)(struct device *dev, struct vm_area_struct *vma,
> +			     void *cpu_addr, dma_addr_t handle, size_t size);
> +
>  };
>  
>  /*
> @@ -204,6 +207,15 @@ dma_cache_sync(struct device *dev, void *vaddr, si=
ze_t
size,
>  		flush_kernel_dcache_range((unsigned long)vaddr, size);
>  }
>  
> +static inline int
> +dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
> +		  void *cpu_addr, dma_addr_t handle, size_t size)
> +{
> +	if (!hppa_dma_ops->mmap_coherent)
> +		return -ENXIO;
> +	return hppa_dma_ops->mmap_coherent(dev, vma, cpu_addr, handle, size);=

> +}
> +
>  static inline void *
>  parisc_walk_tree(struct device *dev)
>  {

Tx,
    J.
=0A
--_=__=_XaM3_.1219406676.2A.885565.42.15885.52.42.007.184490982
Content-Type: text/plain;
	name="=?iso-8859-1?Q?TI2.txt?="
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="=?iso-8859-1?Q?TI2.txt?="

--- ./drivers/parisc/iommu-helpers.h.Orig	2008-08-01 12:57:22.000000000 +=
0000=0A+++ ./drivers/parisc/iommu-helpers.h	2008-08-22 08:07:26.000000000=
 +0000=0A@@ -172,3 +172,16 @@=0A 	return n_mappings;=0A }=0A =0A+static i=
nt iommu_dma_mmap_coherent(struct device *dev,=0A+				  struct vm_area_st=
ruct *vma,=0A+				  void *cpu_addr, dma_addr_t handle,=0A+				  size_t si=
ze)=0A+{=0A+	struct page *pg;=0A+	pgprot_val(vma->vm_page_prot) |=3D _PAG=
E_NO_CACHE;=0A+	pg =3D virt_to_page(cpu_addr);=0A+	return remap_pfn_range=
(vma, vma->vm_start,=0A+			       page_to_pfn(pg) + vma->vm_pgoff,=0A+			=
       size, vma->vm_page_prot);=0A+}=0A+=0A--- ./drivers/parisc/ccio-dma=
.c.Orig	2008-08-22 07:49:21.000000000 +0000=0A+++ ./drivers/parisc/ccio-d=
ma.c	2008-08-22 08:06:32.000000000 +0000=0A@@ -1005,19 +1005,6 @@=0A 	DBG=
_RUN_SG("%s() DONE (nents %d)\n", __func__, nents);=0A }=0A =0A-static in=
t ccio_dma_mmap_coherent(struct device *dev,=0A-				  struct vm_area_stru=
ct *vma,=0A-				  void *cpu_addr, dma_addr_t handle,=0A-				  size_t size=
)=0A-{=0A-	struct page *pg;=0A-	pgprot_val(vma->vm_page_prot) |=3D _PAGE_=
NO_CACHE;=0A-	pg =3D virt_to_page(cpu_addr);=0A-	return remap_pfn_range(v=
ma, vma->vm_start,=0A-			       page_to_pfn(pg) + vma->vm_pgoff,=0A-			  =
     size, vma->vm_page_prot);=0A-}=0A-=0A static struct hppa_dma_ops cci=
o_ops =3D {=0A 	.dma_supported =3D	ccio_dma_supported,=0A 	.alloc_consist=
ent =3D	ccio_alloc_consistent,=0A@@ -1031,7 +1018,7 @@=0A 	.dma_sync_sing=
le_for_device =3D	NULL,	/* NOP for U2/Uturn */=0A 	.dma_sync_sg_for_cpu =3D=
		NULL,	/* ditto */=0A 	.dma_sync_sg_for_device =3D		NULL,	/* ditto */=0A=
-	.mmap_coherent =3D	ccio_dma_mmap_coherent,=0A+	.mmap_coherent =3D	iommu=
_dma_mmap_coherent,=0A };=0A =0A #ifdef CONFIG_PROC_FS=0A--- ./drivers/pa=
risc/sba_iommu.c.Orig	2008-08-22 07:49:21.000000000 +0000=0A+++ ./drivers=
/parisc/sba_iommu.c	2008-08-22 08:08:30.000000000 +0000=0A@@ -1057,19 +10=
57,6 @@=0A =0A }=0A =0A-static int sba_dma_mmap_coherent(struct device *d=
ev,=0A-				 struct vm_area_struct *vma,=0A-				 void *cpu_addr, dma_addr_=
t handle,=0A-				 size_t size)=0A-{=0A-	struct page *pg;=0A-	pgprot_val(v=
ma->vm_page_prot) |=3D _PAGE_NO_CACHE;=0A-	pg =3D virt_to_page(cpu_addr);=
=0A-	return remap_pfn_range(vma, vma->vm_start,=0A-			       page_to_pfn(=
pg) + vma->vm_pgoff,=0A-			       size, vma->vm_page_prot);=0A-}=0A-=0A s=
tatic struct hppa_dma_ops sba_ops =3D {=0A 	.dma_supported =3D	sba_dma_su=
pported,=0A 	.alloc_consistent =3D	sba_alloc_consistent,=0A@@ -1083,7 +10=
70,7 @@=0A 	.dma_sync_single_for_device =3D	NULL,=0A 	.dma_sync_sg_for_cp=
u =3D		NULL,=0A 	.dma_sync_sg_for_device =3D	NULL,=0A-	.mmap_coherent =3D=
	sba_dma_mmap_coherent,=0A+	.mmap_coherent =3D	iommu_dma_mmap_coherent,=0A=
 };=0A =0A =0A
--_=__=_XaM3_.1219406676.2A.885565.42.15885.52.42.007.184490982--
